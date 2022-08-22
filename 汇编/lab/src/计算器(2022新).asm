    .486
    .model flat,stdcall
    option casemap:none   ; case sensitive

;     include files
;     ~~~~~~~~~~~~~
    include \MASM32\INCLUDE\windows.inc
    include \MASM32\INCLUDE\masm32.inc
    include \MASM32\INCLUDE\gdi32.inc
    include \MASM32\INCLUDE\user32.inc
    include \MASM32\INCLUDE\kernel32.inc
    include \MASM32\INCLUDE\Comctl32.inc
    include \MASM32\INCLUDE\comdlg32.inc
    include \MASM32\INCLUDE\shell32.inc
    include \MASM32\INCLUDE\masm32rt.inc

;     libraries
;     ~~~~~~~~~
    includelib \MASM32\LIB\masm32.lib
    includelib \MASM32\LIB\msvcrt.lib
    includelib \MASM32\LIB\gdi32.lib
    includelib \MASM32\LIB\user32.lib
    includelib \MASM32\LIB\kernel32.lib
    includelib \MASM32\LIB\Comctl32.lib
    includelib \MASM32\LIB\comdlg32.lib
    includelib \MASM32\LIB\shell32.lib

    ID_SCREEN   EQU 100
    ID_ZERO     EQU 200
    ID_ONE      EQU 201
    ID_TWO      EQU 202
    ID_THREE    EQU 203
    ID_FOUR     EQU 204
    ID_FIVE     EQU 205
    ID_SIX      EQU 206
    ID_SEVEN    EQU 207
    ID_EIGHT    EQU 208
    ID_NINE     EQU 209

    ID_ADD      EQU 301
    ID_SUB      EQU 302
    ID_MUL      EQU 303
    ID_DIV      EQU 304

    ID_SIN      EQU 401
    ID_COS      EQU 402
    ID_TAN      EQU 403

    ID_FP       EQU 501
    ID_EQU      EQU 502
    ID_MIN      EQU 503

    WinMain PROTO :DWORD,:DWORD,:DWORD,:DWORD
    WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD
    CreateButton PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
    FlashMsg PROTO
    ResolveTri PROTO :DWORD
    ResolveMin PROTO
    ResolveDbl PROTO
    sprintf PROTO C :PTR SBYTE, :PTR SBYTE, :VARARG
    sscanf  PROTO C :PTR SBYTE, :PTR SBYTE, :VARARG
    memset PROTO C :PTR SBYTE, :DWORD, :DWORD

.data
    hInstance   dd ?
    hWnd        dd ?
    calcName    db "Calculator", 0
    className   db "calc_Class"
    btnCName    db "BUTTON", 0
    staticCName db "STATIC", 0
    staticInit  db "0", 0
    commandLine dd ?
    hStatic     dd ?

    atofFmt     db "%f", 0
    ftoaFmt     db "%.6lf", 0

    ; whether the first operand
    firstExec   dd 0
    ; first operand buf
    firstOpe    db 32 DUP(0)
    ; second operand buf
    secondOpe  db 32 DUP(0)
    ; first buf curr id
    firstId     dd 0
    ; second buf curr id
    secondId    dd 0
    ; current op id
    currOpId    dd 0
    ; display res
    resDisplay  db 32 DUP(0)
    ; is display res
    isDisplay   dd 0

    TEXT_ZERO     db "0", 0
    TEXT_ONE      db "1", 0
    TEXT_TWO      db "2", 0
    TEXT_THREE    db "3", 0
    TEXT_FOUR     db "4", 0
    TEXT_FIVE     db "5", 0
    TEXT_SIX      db "6", 0
    TEXT_SEVEN    db "7", 0
    TEXT_EIGHT    db "8", 0
    TEXT_NINE     db "9", 0
    TEXT_ADD      db "+", 0
    TEXT_SUB      db "-", 0
    TEXT_MUL      db "*", 0
    TEXT_DIV      db "/", 0
    TEXT_MIN      db "-", 0
    TEXT_FP       db ".", 0
    TEXT_EQU      db "=", 0
    TEXT_SIN      db "sin", 0
    TEXT_COS      db "cos", 0
    TEXT_TAN      db "tan", 0

.code

start:
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke GetCommandLine
    mov commandLine, eax

    invoke WinMain, hInstance, NULL, commandLine, SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc    hInst: DWORD, 
                hPrevInst: DWORD,
                CmdLine: DWORD,
                CmdShow: DWORD
    local wc    :WNDCLASSEX
    local msg   :MSG
    local Wwd   :DWORD
    local Wht   :DWORD
    local Wtx   :DWORD
    local Wty   :DWORD

    mov wc.cbSize,         sizeof WNDCLASSEX
    mov wc.style,          CS_HREDRAW or CS_VREDRAW \
                             or CS_BYTEALIGNWINDOW
    mov wc.lpfnWndProc,    offset WndProc
    mov wc.cbClsExtra,     NULL
    mov wc.cbWndExtra,     NULL
    push hInst
    pop wc.hInstance
    mov wc.hbrBackground,  COLOR_BTNFACE+1
    mov wc.lpszMenuName,   NULL
    mov wc.lpszClassName,  offset className
    invoke LoadCursor,NULL,IDC_ARROW
    mov wc.hCursor,        eax

    invoke RegisterClassEx, addr wc

    mov Wwd, 420
    mov Wht, 300
    mov Wtx, 200
    mov Wty, 200
    invoke CreateWindowEx, WS_EX_LEFT, 
                addr className,
                addr calcName,
                WS_OVERLAPPED or WS_SYSMENU,
                Wtx,Wty,Wwd,Wht,
                NULL,NULL,
                hInst,NULL
    mov hWnd, eax
    
    invoke ShowWindow, hWnd, SW_SHOWNORMAL
    invoke UpdateWindow, hWnd

    StartLoop:
        invoke GetMessage, addr msg, NULL, 0, 0
        cmp eax, 0
        je ExitLoop
        invoke TranslateMessage, ADDR msg
        invoke DispatchMessage,  ADDR msg
        jmp StartLoop
    ExitLoop:
    mov eax, msg.wParam
    ret
WinMain endp

WndProc proc hWin   :DWORD,
             uMsg   :DWORD,
             wParam :DWORD,
             lParam :DWORD
    .if uMsg == WM_CREATE
        ; invoke CreateButton, hWin, 20, 20, 160, 60, ID_SIN, offset TEXT_SIN
        invoke CreateWindowEx, 0,
            addr staticCName, addr staticInit,
            WS_CHILD or WS_VISIBLE or WS_BORDER or SS_RIGHT or SS_CENTERIMAGE,
            20, 20, 360, 50, hWin, ID_SCREEN,
            hWin, NULL
        mov hStatic, eax
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_SIN,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            20, 80, 60, 30, hWin, ID_SIN,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_COS,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            20, 120, 60, 30, hWin, ID_COS,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_TAN,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            20, 160, 60, 30, hWin, ID_TAN,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_MIN,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            20, 200, 60, 30, hWin, ID_MIN,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_SEVEN,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            100, 80, 60, 30, hWin, ID_SEVEN,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_FOUR,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            100, 120, 60, 30, hWin, ID_FOUR,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_ONE,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            100, 160, 60, 30, hWin, ID_ONE,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_FP,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            100, 200, 60, 30, hWin, ID_FP,
            hWin, NULL
         invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_EIGHT,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            180, 80, 60, 30, hWin, ID_EIGHT,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_FIVE,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            180, 120, 60, 30, hWin, ID_FIVE,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_TWO,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            180, 160, 60, 30, hWin, ID_TWO,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_ZERO,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            180, 200, 60, 30, hWin, ID_ZERO,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_NINE,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            260, 80, 60, 30, hWin, ID_NINE,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_SIX,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            260, 120, 60, 30, hWin, ID_SIX,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_THREE,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            260, 160, 60, 30, hWin, ID_THREE,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_EQU,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            260, 200, 60, 30, hWin, ID_EQU,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_DIV,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            340, 80, 60, 30, hWin, ID_DIV,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_MUL,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            340, 120, 60, 30, hWin, ID_MUL,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_SUB,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            340, 160, 60, 30, hWin, ID_SUB,
            hWin, NULL
        invoke CreateWindowEx, 0, 
            addr btnCName, addr TEXT_ADD,
            WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
            340, 200, 60, 30, hWin, ID_ADD,
            hWin, NULL
        mov eax, 0
        ret
    .elseif uMsg == WM_COMMAND
        .if wParam < 300
            mov eax, wParam
            sub eax, 200
            .if isDisplay == 1
                mov isDisplay, 0
            .endif
            .if firstExec == 0
                mov ecx, firstId
                lea ebx, firstOpe
                add eax, 48
                mov [ebx][ecx], eax
                inc firstId
            .else
                mov ecx, secondId
                lea ebx, secondOpe
                add eax, 48
                mov [ebx][ecx], eax
                inc secondId
            .endif  
            invoke FlashMsg
        .elseif wParam < 400
            .if isDisplay == 1
                lea esi, resDisplay
                lea edi, firstOpe
                cld
                mov ecx, 32
                rep movsb
                mov isDisplay, 0
            .endif
            .if firstExec == 0
                mov firstExec, 1
                push wParam
                pop currOpId
            .else
                invoke ResolveDbl
                lea esi, resDisplay
                lea edi, firstOpe
                cld
                mov ecx, 32
                rep movsb
                mov firstExec, 1
                push wParam
                pop currOpId
                invoke memset, addr secondOpe, 0, 32
                mov secondId, 0
            .endif
        .elseif wParam < 500
            .if isDisplay == 1
                lea esi, resDisplay
                lea edi, firstOpe
                cld
                mov ecx, 32
                rep movsb
                mov isDisplay, 0
            .endif
            mov currOpId, 0
            invoke ResolveTri, wParam
            invoke memset, addr firstOpe, 0, 32
            mov firstId, 0
            invoke memset, addr secondOpe, 0, 32
            mov secondId, 0
            mov firstExec, 0
            mov isDisplay, 1
        .elseif wParam == 501
            .if firstExec == 0
                mov ecx, firstId
                lea ebx, firstOpe
                mov al, 46
                mov [ebx][ecx], al
                inc firstId
            .else
                mov ecx, secondId
                lea ebx, secondOpe
                mov al, 46
                mov [ebx][ecx], al
                inc secondId
            .endif  
            invoke FlashMsg
        .elseif wParam == 502
            .if firstExec == 1
                invoke ResolveDbl
                invoke memset, addr firstOpe, 0, 32
                mov firstId, 0
                invoke memset, addr secondOpe, 0, 32
                mov secondId, 0
                mov firstExec, 0
                mov isDisplay, 1
            .endif
        .elseif wParam == 503
            .if firstExec == 0
                mov ecx, firstId
                lea ebx, firstOpe
                mov edx, ecx
                dec edx
                FstMovLab:
                    mov al, [ebx][edx]
                    mov [ebx][ecx], al
                    dec edx
                    dec ecx
                    jnz FstMovLab
                mov al, 45
                mov [ebx][ecx], al
                inc firstId
            .else
                mov ecx, secondId
                lea ebx, secondOpe
                mov edx, ecx
                dec edx
                SndMovLab:
                    mov al, [ebx][edx]
                    mov [ebx][ecx], al
                    dec edx
                    dec ecx
                    jnz SndMovLab
                mov al, 45
                mov [ebx][ecx], al
                inc secondId
            .endif  
            invoke FlashMsg
        .endif
    .elseif uMsg == WM_DESTROY
        invoke PostQuitMessage, NULL
        mov eax, 0
        ret
    .endif 
    invoke DefWindowProc, hWin, uMsg, wParam, lParam
    ret
WndProc endp

CreateButton proc hParent   :DWORD,
                  a         :DWORD,
                  b         :DWORD,
                  wd        :DWORD,
                  ht        :DWORD,
                  ID        :DWORD,
                  text      :DWORD  
    invoke CreateWindowEx, 0, 
        offset btnCName, text,
        WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
        a, b, wd, ht, hParent, ID,
        hParent, NULL
    ret
CreateButton endp

FlashMsg proc
    .if firstExec == 0
        invoke SetWindowText, hStatic, addr firstOpe
    .else
        invoke SetWindowText, hStatic, addr secondOpe
    .endif
    ret
FlashMsg endp

ResolveTri proc     typ     :DWORD
    local amt   :real4
    local lamt  :real8
    invoke sscanf, addr firstOpe, addr atofFmt, addr amt
    .if typ == ID_SIN
        fld amt
        fsin
        fstp lamt
    .elseif typ == ID_COS
        fld amt
        fcos
        fstp lamt
    .else
        fld amt
        fptan
        fstp lamt
    .endif
    invoke sprintf, addr resDisplay, addr ftoaFmt, lamt
    invoke SetWindowText, hStatic, addr resDisplay
    ret
ResolveTri endp

ResolveDbl proc
    local v1    :real4
    local v2    :real4
    local lans  :real8
    invoke sscanf, addr firstOpe, addr atofFmt, addr v1
    invoke sscanf, addr secondOpe, addr atofFmt, addr v2
    fld v1
    fld v2
    .if currOpId == ID_ADD
        fadd
    .elseif currOpId == ID_SUB
        fsub
    .elseif currOpId == ID_MUL
        fmul
    .else
        fdiv
    .endif
    fstp lans
    invoke sprintf, addr resDisplay, addr ftoaFmt, lans
    invoke SetWindowText, hStatic, addr resDisplay
    ret
ResolveDbl endp
end start