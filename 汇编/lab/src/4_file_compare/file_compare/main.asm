.386                            ;

.model flat,stdcall             ;

option casemap:none             

include    windows.inc
include    kernel32.inc
includelib    kernel32.lib
include    user32.inc
includelib    user32.lib
include msvcrt.inc
includelib msvcrt.lib

printf PROTO C :ptr sbyte, :VARARG	
scanf PROTO C :ptr sbyte, :VARARG
strlen PROTO C :ptr sbyte, :VARARG
sprintf PROTO C :ptr sbyte, :VARARG
strcmp PROTO C :ptr sbyte, :VARARG
strcat PROTO C :ptr sbyte, :VARARG

.data                           
H_app dd ?
H_win dd ?
H_edit1 HWND ?
H_edit2 HWND ?
file1_path byte 256 dup(?)
file2_path byte 256 dup(?)
differs byte 2048 dup(0)
differ_num dd ?
buffer1 byte 2048 dup(0)
buffer2 byte 2048 dup(0)

winClassName db '文件比较',0
winCaptionName db '文件比较',0
edit byte 'edit', 0
button byte 'button', 0
showbutton byte '确认', 0
SameContent	 db '文件内容相同', 0
DiffContent db '行数: %d', 0AH,0
szBoxTitle db '比较结果', 0

.code

ReadLine proc fp: HANDLE, buffer:ptr byte
	local len: dword
	local chr: byte

	mov esi, buffer
	mov edi, 0

L1: 
	invoke ReadFile, fp, addr chr, 1, addr len, NULL
	cmp len, 0
	je L2
	;cmp chr, 13
	;je L2
	cmp chr, 10
	je L2
	mov al, chr
	mov byte ptr [esi], al
	inc esi
	inc edi
	jmp L1

L2:
	mov byte ptr [esi], 0
	mov eax,edi
	ret

ReadLine endp

MyCompareFile proc fpath1:ptr byte, fpath2:ptr byte
	local fp1 :HANDLE
	local fp2 :HANDLE
	local lp1 :dword
	local lp2 :dword
	local index_line :dword
	local buffer_differ[1024] :byte

	invoke CreateFile, fpath1, GENERIC_READ, FILE_SHARE_READ, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
	mov fp1, eax
	invoke CreateFile, fpath2, GENERIC_READ, FILE_SHARE_READ, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
	mov fp2, eax
	mov differ_num, 0
	mov index_line, 0
	mov esi, offset differs
	mov byte ptr[esi], 0
L0:
	inc index_line
	invoke ReadLine, fp1, offset buffer1
	mov lp1, eax
	invoke ReadLine, fp2, offset buffer2
	mov lp2, eax

L1:
	cmp lp1, 0
	jne L3
	cmp lp2, 0
	jne L2
	;都等于0
	jmp ENDFUNC
L2:
	invoke sprintf, addr buffer_differ, offset DiffContent, index_line
	invoke strcat, offset differs, addr buffer_differ
	inc differ_num
	jmp L0

L3:
	cmp lp2,0
	jne L4

	invoke sprintf, addr buffer_differ, offset DiffContent, index_line
	invoke strcat, offset differs, addr buffer_differ
	inc differ_num
	jmp L0

L4:
;都不等于0
	invoke strcmp, offset buffer1, offset buffer2
	cmp eax, 0
	je L0
	invoke sprintf, addr buffer_differ, offset DiffContent, index_line
	invoke strcat, offset differs, addr buffer_differ
	inc differ_num
	jmp L0

ENDFUNC:
	
	ret 
MyCompareFile endp

_WinMain proc uses ebx edi esi, hWnd, uMsg, wParam, lParam
		local structps: PAINTSTRUCT
		local structrect: RECT
		local hDc

		mov eax, uMsg

		.IF eax==WM_PAINT
			invoke BeginPaint, hWnd, addr structps
			mov hDc, eax
			invoke EndPaint, hWnd, addr structps
		.ELSEIF eax==WM_CLOSE
			invoke DestroyWindow, H_win
			invoke PostQuitMessage, NULL
		.ELSEIF eax==WM_CREATE
			invoke CreateWindowEx, NULL, OFFSET button, OFFSET showbutton, WS_CHILD OR  WS_VISIBLE,	120, 100, 150, 25, hWnd, 15,	H_app, NULL    
			invoke CreateWindowEx, WS_EX_CLIENTEDGE, OFFSET edit, NULL, WS_CHILD OR  WS_VISIBLE OR WS_BORDER OR	ES_LEFT	OR ES_AUTOHSCROLL, 10, 10, 350, 35, hWnd, 1, H_app, NULL
			mov H_edit1, eax
			invoke CreateWindowEx, WS_EX_CLIENTEDGE, OFFSET edit, NULL, WS_CHILD OR  WS_VISIBLE	OR WS_BORDER OR	ES_LEFT	OR ES_AUTOHSCROLL, 10, 50, 350, 35, hWnd, 2, H_app,	NULL 
			mov H_edit2, eax		
		.ELSEIF	eax==WM_COMMAND
			mov eax,wParam
			.IF eax==15
				invoke GetWindowText,H_edit1,offset file1_path,512
				invoke GetWindowText,H_edit2,offset file2_path,512
				invoke MyCompareFile, offset file1_path, offset file2_path
				.IF	differ_num == 0
					invoke MessageBox, hWnd, offset SameContent, offset szBoxTitle,	MB_OK + MB_ICONQUESTION
				.ELSE
					invoke MessageBox, hWnd, offset differs, offset szBoxTitle,	MB_OK + MB_ICONQUESTION
				.ENDIF
			.ENDIF
		.ELSE
			invoke DefWindowProc, hWnd, uMsg, wParam, lParam
			ret
		.ENDIF

		ret
_WinMain endp


main proc                          
        local structWndClass: WNDCLASSEX
		local structMsg: MSG
		invoke GetModuleHandle, NULL
		mov H_app,eax
		invoke RtlZeroMemory, addr structWndClass, sizeof structWndClass
		invoke LoadCursor, 0, IDC_ARROW
		mov structWndClass.hCursor, eax
		mov eax,H_app
		mov structWndClass.hInstance, eax
		mov structWndClass.cbSize, sizeof WNDCLASSEX
		mov structWndClass.style, CS_HREDRAW or CS_VREDRAW
		mov structWndClass.lpfnWndProc, offset _WinMain
		mov structWndClass.hbrBackground, COLOR_WINDOW + 1
		mov structWndClass.lpszClassName, offset winClassName
		invoke RegisterClassEx, addr structWndClass
		invoke CreateWindowEx, WS_EX_CLIENTEDGE, offset winClassName, offset winCaptionName, WS_OVERLAPPEDWINDOW, 200, 200, 400, 200, NULL, NULL, H_app, NULL
		mov H_win, eax
		invoke ShowWindow, H_win, SW_SHOWNORMAL
		invoke UpdateWindow, H_win
		
		.WHILE TRUE
			invoke GetMessage, addr	structMsg, NULL, 0, 0
			invoke TranslateMessage, addr structMsg		
			invoke DispatchMessage,	addr structMsg		
		.ENDW
		
		
		invoke ExitProcess, NULL
        ret
main endp
end main