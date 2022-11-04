.386
.model flat, stdcall
option casemap:none

includelib msvcrt.lib
printf PROTO C :ptr sbyte, :VARARG	
scanf PROTO C :ptr sbyte, :VARARG
strlen PROTO C :ptr sbyte, :VARARG

.data
out_s byte "%d %d %d %d ", 0AH, 0
i dword 0
j dword 0
k dword 0
l dword 0
sum dword 0
n dword 10

radix dword 10
.code

main proc
L1:
  mov edx, i
  mov eax, n
  cmp edx, eax
  jge L9
  mov j, 0

L2:
  mov edx, j
  mov eax, n
  cmp edx, eax
  jge L8
  mov k, 0

L3:
  mov edx, k
  mov eax, n
  cmp edx, eax
  jge L7
  mov l, 0

L4:
  mov edx, l
  mov eax, n
  cmp edx, eax
  jge L6

  mov edx, i
  mov eax, j
  add edx, eax
  mov eax, k
  add edx, eax
  mov eax, l
  add edx, eax
  mov sum, edx
  mov edx, sum
  mov eax, n
  cmp edx, eax
  jnz L5
  invoke printf, offset out_s, i, j, k, l

L5:
  mov eax, l
  add eax, 1
  mov l, eax
  jmp L4

L6:
  mov eax, k
  add eax, 1
  mov k, eax
  jmp L3

L7:
  mov eax, j
  add eax, 1
  mov j, eax
  jmp L2

L8:
  mov eax, i
  add eax, 1
  mov i, eax
  jmp L1

L9:
  mov eax, 0
  ret

main endp
end main