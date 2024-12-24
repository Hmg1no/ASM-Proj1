section .data
  msg1 dd 'chess', 0x0A ; words to determine hamming distance
  msg2 dd 'minute', 0x0A

  format: db "The Hamming distance between msg1 and msg2 is:",10,"%d",10,0


  count1 equ $-msg1
  count2 equ $-msg2


section .text
  extern printf
  global main

main: 

  ;initialize all registers to 0, avoid garbage data
  
  xor eax, eax
  xor ebx, ebx
  xor ecx, ecx
  xor edx, edx


  ;Check if msgs are stored
  mov eax, 4 ;sys write
  mov ebx, 1 ; std output 
  mov ecx, msg1  ;store first input
  mov edx, count1 ;store length of first input
  int 0x80
    

  mov eax, 4 ;sys write 
  mov ebx, 1 ;std output
  mov edi, msg2 ;store second input
  mov esi, count2 ; store length of input
  int 0x80

  mov ecx, 0
  jmp hamming_loop


hamming_loop:

  ; load a character(byte) into the register
  mov al, byte[eax]
  mov cl, byte[ecx]

  ;XOR characters to find differing bits
  xor al, bl
  mov bl, al ;save value of al
  jmp count_bits

increment_counter:
  add ecx, 1
  jmp count_bits

increment_bit:

  ;Move to next character (byte)
  inc eax
  inc esi

  jmp hamming_loop


exitprog:

  push ecx ;stored hamming distance value on stack
  push format ;formating string for printf function

  ;call printf; print result function
  add esp, byte 8
  mov eax, 1
  mov eax, 0

  int 0x80; exit

    
