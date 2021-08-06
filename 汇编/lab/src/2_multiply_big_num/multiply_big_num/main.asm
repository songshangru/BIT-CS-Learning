.386
.model flat, stdcall
option casemap:none

includelib msvcrt.lib
printf PROTO C :ptr sbyte, :VARARG	
scanf PROTO C :ptr sbyte, :VARARG
strlen PROTO C :ptr sbyte, :VARARG

.data
input_s byte "%s",0
input_str1 byte 200 dup(0)
input_str2 byte 200 dup(0)
output_str byte 200 dup(0)
input_num1 dword 200 dup(0)
input_num2 dword 200 dup(0)
output_num dword 200 dup(0)


input_len1 dword 0
input_len2 dword 0
output_len dword 0

radix dword 10
.code

str_to_num proc stdcall str_in :ptr byte, num_out :ptr dword, len :dword
  mov ecx, len
  mov esi, str_in

L1:
  movzx eax, byte ptr [esi]
  sub eax, 30h
  push eax
  inc esi

  loop L1
  
  mov ecx, len
  mov esi, num_out
L2:
  pop eax
  mov dword ptr [esi],eax
  add esi, 4

  loop L2

  ret
str_to_num endp

num_to_str proc stdcall str_out :ptr byte, num_in :ptr dword, len :dword
  mov ecx, len
  mov esi, num_in
L1:
  mov eax,dword ptr [esi]
  add esi, 4
  push eax
  loop L1

  mov ecx, len
  mov esi, str_out
L2:
  pop eax
  add eax, 30h
  mov byte ptr [esi], al
  inc esi
  loop L2


  ret
num_to_str endp

big_num_mul proc far C 
  mov ecx, input_len1
  xor edi, edi
L1:
  xor esi, esi
  
L2:
  mov eax,dword ptr input_num1[edi*4]
  mul input_num2[esi*4]

  mov ebx, esi
  add ebx, edi
  add eax,output_num[ebx*4]
  
  mov ebx, 10
  div ebx

  mov ebx, esi
  add ebx, edi

  mov output_num[ebx*4], edx
  add output_num[ebx*4+4], eax
  
  inc esi
  mov ebx, input_len2
  cmp esi, ebx
  jb L2
  
  inc edi
  loop L1

  mov eax, input_len1
  add eax, input_len2

  cmp output_num[eax*4-4],0
  jz DLZ
END_FUNC:
  mov output_len, eax
  ret
DLZ:
  sub eax, 1
  jmp END_FUNC
big_num_mul endp

.code
main proc
     invoke scanf, offset input_s, offset input_str1
	 invoke strlen, offset input_str1
	 mov input_len1, eax
	 invoke str_to_num, offset input_str1, offset input_num1, eax

	 invoke scanf, offset input_s, offset input_str2
	 invoke strlen, offset input_str2
	 mov input_len2, eax
	 invoke str_to_num, offset input_str2, offset input_num2, eax

	 invoke big_num_mul
	 mov eax, output_len
	 invoke num_to_str, offset output_str, offset output_num, eax


	 invoke printf, offset input_s, offset output_str

	 ret

main endp
end main