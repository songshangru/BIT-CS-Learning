.386

.model flat,stdcall
option casemap:none

include define.inc
include		windows.inc
include		user32.inc
includelib	user32.lib
include		kernel32.inc
includelib	kernel32.lib
include		Gdi32.inc
includelib	Gdi32.lib
include     winmm.inc
includelib  winmm.lib
include     Msimg32.inc
includelib  Msimg32.lib

includelib msvcrt.lib

rand	PROTO C
printf PROTO C :dword, :vararg
public _draw_item,_draw_final

extern h_dc_buffer:dword,h_dc_player1_body:dword, h_dc_player1_head:dword, speed:dword,h_dc_bmp:dword,h_dc_player1_tail:dword,h_dc_apple:dword,h_dc_apple_mask:dword,h_dc_grass:dword,h_dc_emoji:dword,h_dc_player2_head:dword,h_dc_player2_tail:dword,h_dc_player2_body:dword,h_dc_wall:dword,h_dc_fast:dword,h_dc_dizzy:dword,h_dc_dizzy_mask:dword,h_dc_large:dword,h_dc_large_mask:dword,player1_size:dword,player2_size:dword,h_dc_num:dword


.data
dizzy_cnt dword 0

.data?

fast_index dword ?
fast_cnt dword ?


player_struct STRUCT 
    head_x dword ?
    head_y dword ?
    emoji_cnt   dword ?
    emoji_kind  dword ?       
    big_cnt     dword ?
player_struct ENDS

player1 player_struct {}
player2 player_struct {}

.const 
out_format_int byte '%u', 20h,0

.code

_div_part PROC @player_y:dword,@player_x:dword,@size:dword
    add @player_y, 1200
    add @player_x, 700
    mov ecx, 2400
    sub ecx, @size
    mov edx, 1400
    sub edx, @size
    mov eax, 0ffffffh
    .if @player_y > ecx
        sub @player_y, 2400
        sub @player_x, 700
        invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@size, @size,h_dc_bmp,0,0,@size,@size,eax
    .elseif @player_y < 1200
        sub @player_x, 700
        invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@size, @size,h_dc_bmp,0,0,@size,@size,eax
    .elseif @player_x > edx
        sub @player_y, 1200
        sub @player_x, 1400
        invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@size, @size,h_dc_bmp,0,0,@size,@size,eax
    .elseif @player_x < 700
        sub @player_y, 1200
        invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@size, @size,h_dc_bmp,0,0,@size,@size,eax
    .endif
    ret
_div_part ENDP

_draw_head PROC uses esi edi, player:dword, index_x:dword, index_y:dword, dir:dword, frame_time:dword
    local @player_x,@player_y, @dis, @head_size,@h_dc
    assume edi:ptr player_struct
    .if player == 1
        mov edi, offset player1
        mov eax, h_dc_player1_head
        mov @h_dc, eax
    .else 
        mov edi, offset player2
        mov eax, h_dc_player2_head
        mov @h_dc, eax
    .endif
    mov @head_size, cell_size
    mov ecx, index_x
    imul ecx, cell_size
    mov @player_x, ecx
    mov ecx, index_y
    imul ecx, cell_size
    mov @player_y, ecx
    mov ecx, speed
    imul ecx, frame_time
    .if dir == 1
        neg ecx
        add @player_x, ecx
    .elseif dir == 2
        add @player_y, ecx
    .elseif dir == 3
        add @player_x, ecx
    .elseif dir == 4
        neg ecx
        add @player_y, ecx
    .endif

    ;改变蛇大小
    .if [edi].big_cnt > 0
        add @head_size,50
        sub  @player_y,25
        sub @player_x,25
    .endif

    mov ecx, @player_x
    mov [edi].head_x, ecx
    mov ecx, @player_y
    mov [edi].head_y, ecx

    mov esi, frame_time
    invoke StretchBlt,h_dc_bmp,0,0,@head_size, @head_size,@h_dc,0,0,136,136,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@head_size, @head_size,h_dc_bmp,0,0,@head_size,@head_size,eax

    invoke _div_part,@player_y,@player_x ,@head_size
    
    assume edi:nothing
    ret
_draw_head ENDP

_draw_body PROC uses esi edi,player:dword, index_x:dword, index_y:dword, dir:dword, frame_time:dword
    local @player_x:dword,@player_y:dword, @dis, @body_size,@h_dc
    assume edi:ptr player_struct
    .if player == 1
        mov edi, offset player1
        mov eax, h_dc_player1_body
        mov @h_dc, eax
    .else 
        mov edi, offset player2
        mov eax, h_dc_player2_body
        mov @h_dc, eax
    .endif
    mov @body_size, cell_size
    mov ecx, index_x
    imul ecx, cell_size
    mov @player_x, ecx
    mov ecx, index_y
    imul ecx, cell_size
    mov @player_y, ecx
    mov ecx, speed
    imul ecx, frame_time
    .if dir == 1
        neg ecx
        add @player_x, ecx
    .elseif dir == 2
        add @player_y, ecx
    .elseif dir == 3
        add @player_x, ecx
    .elseif dir == 4
        neg ecx
        add @player_y, ecx
    .endif

    ;改变蛇大小
    .if [edi].big_cnt > 0
        add @body_size,50
        sub  @player_y,25
        sub @player_x,25
    .endif

    mov esi, frame_time
    invoke StretchBlt,h_dc_bmp,0,0,@body_size, @body_size,@h_dc,0,0,136,136,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@body_size, @body_size,h_dc_bmp,0,0,@body_size,@body_size,eax

    invoke _div_part,@player_y,@player_x ,@body_size
    assume edi:nothing
    ret
_draw_body ENDP

_draw_tail PROC uses esi edi,player:dword, index_x:dword, index_y:dword, dir:dword, frame_time:dword
    local @player_x:dword,@player_y:dword, @dis, @tail_size, @bmp_x,@h_dc_player,@h_dc
    assume edi:ptr player_struct
    .if player == 1
        mov edi, offset player1
        mov eax, h_dc_player1_tail
        mov @h_dc, eax
    .else 
        mov edi, offset player2
        mov eax, h_dc_player2_tail
        mov @h_dc, eax
    .endif
    mov @tail_size, cell_size
    mov ecx, index_x
    imul ecx, cell_size
    mov @player_x, ecx
    mov ecx, index_y
    imul ecx, cell_size
    mov @player_y, ecx

    mov ecx, speed
    imul ecx, frame_time
    .if dir == 1
        mov @bmp_x, 0
        neg ecx
        add @player_x, ecx
    .elseif dir == 2
        mov @bmp_x, 100
        add @player_y, ecx
    .elseif dir == 3
        mov @bmp_x, 200
        add @player_x, ecx
    .elseif dir == 4
        mov @bmp_x, 300
        neg ecx
        add @player_y, ecx
    .elseif dir == 5
        mov @bmp_x, 0
    .elseif dir == 6
        mov @bmp_x, 100
    .elseif dir == 7
        mov @bmp_x, 200
    .elseif dir == 8
        mov @bmp_x, 300
    .endif

    ;改变蛇大小
    .if [edi].big_cnt > 0
        add @tail_size,50
        sub  @player_y,25
        sub @player_x,25
    .endif

    mov esi, frame_time
    invoke StretchBlt,h_dc_bmp,0,0,@tail_size, @tail_size,@h_dc,@bmp_x,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],@player_y,@player_x,@tail_size, @tail_size,h_dc_bmp,0,0,@tail_size,@tail_size,eax

    
    invoke _div_part,@player_y,@player_x ,@tail_size
    assume edi:nothing
    ret
_draw_tail ENDP

_draw_apple PROC uses esi edi,index_x:dword, index_y:dword, frame_time:dword
    local @apple_size,@apple_x,@apple_y
    mov @apple_size, cell_size
    mov eax, index_x
    imul eax, cell_size
    mov @apple_x, eax
    mov eax, index_y
    imul eax, cell_size
    mov @apple_y, eax

    xor edx,edx
    mov eax, frame_time

    xor edx,edx
    mov ecx, 5
    div ecx
    
    .if eax > 5
        mov ecx, 10
        sub ecx, eax
        mov eax, ecx
    .endif
    add @apple_x,eax
    add @apple_y,eax

    sal eax, 1
    sub @apple_size,eax

    mov esi, frame_time
    invoke StretchBlt,h_dc_buffer[4*esi],@apple_y,@apple_x,@apple_size, @apple_size,h_dc_apple_mask,0,0,64,64,SRCAND
    invoke StretchBlt,h_dc_buffer[4*esi],@apple_y,@apple_x,@apple_size, @apple_size,h_dc_apple,0,0,64,64,SRCPAINT
    ret
_draw_apple ENDP

_draw_wall PROC uses esi edi, index_x:dword, index_y:dword, frame_time:dword
    local wall_x,wall_y
    mov eax, index_x
    imul eax, cell_size
    mov wall_x, eax
    mov eax, index_y
    imul eax, cell_size
    mov wall_y, eax

    mov esi, frame_time
    invoke StretchBlt,h_dc_bmp,0,0,cell_size, cell_size,h_dc_wall,0,0,56,56,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],wall_y,wall_x,cell_size, cell_size,h_dc_bmp,0,0,cell_size,cell_size,eax
    ret
_draw_wall ENDP

_draw_grass PROC uses esi edi,index_x:dword, index_y:dword,frame_time:dword
    local @grass_size,@grass_x,@grass_y
    mov @grass_size, cell_size
    add @grass_size,5
    mov eax, index_x
    imul eax, cell_size
    mov @grass_x, eax
    mov eax, index_y
    imul eax, cell_size
    mov @grass_y, eax
    mov esi, frame_time
    invoke StretchBlt,h_dc_bmp,0,0,@grass_size, @grass_size,h_dc_grass,0,0,128,128,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],@grass_y,@grass_x,@grass_size, @grass_size,h_dc_bmp,0,0,@grass_size,@grass_size,eax
    ret
_draw_grass ENDP

_draw_emoji PROC uses esi edi,player:dword,state:dword,frame_time:dword
    local @emoji_size,@emoji_x,@emoji_y,@emoji
    assume edi:ptr player_struct
    .if player == 1
        mov edi, offset player1
    .else 
        mov edi, offset player2
    .endif
    mov @emoji_size, cell_size
    mov eax, [edi].head_x
    sub eax, cell_size/4*3
    mov @emoji_x, eax
    
    mov eax, [edi].head_y
    add eax, cell_size/4
    mov @emoji_y, eax
    mov esi, frame_time

    .if state == 0
        mov eax, 0
    .elseif state == 1
        mov eax, 100
    .elseif state == 2
        mov eax, 200
    .endif

    invoke StretchBlt,h_dc_bmp,0,0,@emoji_size, @emoji_size,h_dc_emoji,eax,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],@emoji_y,@emoji_x,@emoji_size, @emoji_size,h_dc_bmp,0,0,@emoji_size,@emoji_size,eax
    assume edi:nothing
    ret
_draw_emoji ENDP

_draw_fast PROC uses esi,index_x:dword, index_y:dword,frame_time:dword
    local x,y
    mov eax, index_x
    imul eax, cell_size
    mov x, eax
    mov eax, index_y
    imul eax, cell_size
    mov y, eax
    invoke StretchBlt,h_dc_bmp,0,0,cell_size, cell_size,h_dc_fast,fast_index,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],y,x,cell_size, cell_size,h_dc_bmp,0,0,cell_size,cell_size,eax
    inc fast_cnt
    .if fast_cnt == 12
        mov fast_cnt,0
        add fast_index, 100
        .if fast_index == 500
            mov fast_index, 0
        .endif
    .endif
    
    ret
_draw_fast ENDP

_draw_dizzy PROC uses esi,index_x:dword, index_y:dword,frame_time:dword
    local x,y
    mov eax, index_x
    imul eax, cell_size
    mov x, eax
    mov eax, index_y
    imul eax, cell_size
    mov y, eax

    .if dizzy_cnt == 0
        invoke rand
        xor edx,edx
        mov ecx, 30
        div ecx
        sub edx, 15
        .if edx > 0
            add edx, 3
        .else 
            sub edx, 3
        .endif
        add x, edx
        invoke rand
        xor edx,edx
        mov ecx, 30
        div ecx
        sub edx, 15
        .if edx > 0
            add edx,3
        .else 
            sub edx,3
        .endif
        add y, edx
        inc dizzy_cnt
    .else 
        inc dizzy_cnt
        .if dizzy_cnt == 6
            mov dizzy_cnt, 0
        .endif
    .endif 

    mov esi, frame_time
    invoke StretchBlt,h_dc_buffer[4*esi],y,x,cell_size, cell_size,h_dc_dizzy_mask,0,0,50,50,SRCAND
    invoke StretchBlt,h_dc_buffer[4*esi],y,x,cell_size, cell_size,h_dc_dizzy,0,0,50,50,SRCPAINT
    ret
_draw_dizzy ENDP

_draw_large PROC uses esi,index_x:dword, index_y:dword,frame_time:dword
    local x,y
    mov eax, index_x
    imul eax, cell_size
    mov x, eax
    mov eax, index_y
    imul eax, cell_size
    mov y, eax
    mov esi, frame_time
    invoke StretchBlt,h_dc_buffer[4*esi],y,x,cell_size, cell_size,h_dc_large_mask,0,0,50,50,SRCAND
    invoke StretchBlt,h_dc_buffer[4*esi],y,x,cell_size, cell_size,h_dc_large,0,0,50,50,SRCPAINT
    ret
_draw_large ENDP

_draw_num PROC uses esi, index_x:dword, index_y:dword, frame_time:dword, player_size:dword
    local x,y,num1,num2,num3
    mov eax, index_x
    imul eax, cell_size
    mov x, eax
    sub x, 25
    mov eax, index_y
    imul eax, cell_size
    mov y, eax
    sub y, 25
    mov esi, frame_time

    mov eax , player_size
    mov ecx, 10

    xor edx, edx
    div ecx
    imul edx, 100
    mov num3, edx

    xor edx, edx
    div ecx
    imul edx, 100
    mov num2, edx

    xor edx, edx
    div ecx
    imul edx, 100
    mov num1, edx

    invoke StretchBlt,h_dc_bmp,0,0,50, 50,h_dc_num,num1,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],y,x,50, 50,h_dc_bmp,0,0,50,50,eax

    add y, 50
    invoke StretchBlt,h_dc_bmp,0,0,50, 50,h_dc_num,num2,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],y,x,50, 50,h_dc_bmp,0,0,50,50,eax

    add y, 50
    invoke StretchBlt,h_dc_bmp,0,0,50, 50,h_dc_num,num3,0,100,100,SRCCOPY
    mov eax, 0ffffffh
    invoke TransparentBlt,h_dc_buffer[4*esi],y,x,50, 50,h_dc_bmp,0,0,50,50,eax

    ret
_draw_num ENDP

_draw_item PROC item:draw_struct,frame_time:dword
    ; invoke printf, offset out_format_int, item.item
    .if item.item == player1_head
        invoke _draw_head,1,item.x,item.y,item.state,frame_time
    .elseif item.item == player1_body
        invoke _draw_body,1,item.x,item.y,item.state,frame_time
    .elseif item.item == player1_tail
        invoke _draw_tail,1,item.x,item.y,item.state,frame_time
    .elseif item.item == player2_head
        invoke _draw_head,2,item.x,item.y,item.state,frame_time
    .elseif item.item == player2_body
        invoke _draw_body,2,item.x,item.y,item.state,frame_time
    .elseif item.item == player2_tail
        invoke _draw_tail,2,item.x,item.y,item.state,frame_time
    .elseif item.item == apple
        invoke _draw_apple,item.x,item.y,frame_time
    .elseif item.item == wall 
        invoke _draw_wall,item.x,item.y,frame_time 
    .elseif item.item == large  
        invoke _draw_large,item.x,item.y,frame_time
    .elseif item.item == large_eat
        .if item.player == 1
            mov player1.big_cnt,350
        .else
            mov player2.big_cnt,350
        .endif
    .elseif item.item == emoji
        .if item.player == 1
            .if item.state == 0
                mov player1.emoji_cnt, 50
            .else
                mov player1.emoji_cnt, 1
            .endif
            mov eax ,item.state
            mov player1.emoji_kind, eax
        .else
            .if item.state == 0
                mov player2.emoji_cnt, 50
            .else
                mov player2.emoji_cnt, 1
            .endif
            mov eax ,item.state
            mov player2.emoji_kind, eax
        .endif
    .elseif item.item == fast
        invoke _draw_fast,item.x,item.y,frame_time
    .elseif item.item == dizzy
        invoke _draw_dizzy,item.x,item.y,frame_time
    .endif

    ret
_draw_item ENDP

_draw_final PROC frame_time:dword
    .if player1.emoji_cnt != 0
        dec player1.emoji_cnt
        invoke _draw_emoji,1,player1.emoji_kind,frame_time
    .endif
    .if player2.emoji_cnt != 0
        dec player2.emoji_cnt
        invoke _draw_emoji,2,player2.emoji_kind,frame_time
    .endif
    dec player1.big_cnt
    .if player1.big_cnt == 0ffffffffh
        mov player1.big_cnt, 0
    .endif
    dec player2.big_cnt
    .if player2.big_cnt == 0ffffffffh
        mov player2.big_cnt, 0
    .endif

    invoke _draw_num, 1, 1 ,frame_time, player1_size
    invoke _draw_num, 1, 21 ,frame_time, player2_size

    invoke _draw_grass, 9, 10, frame_time
    invoke _draw_grass, 9, 11, frame_time
    invoke _draw_grass, 9, 12, frame_time
    invoke _draw_grass, 9, 13, frame_time
    invoke _draw_grass, 10, 10, frame_time
    invoke _draw_grass, 10, 11, frame_time
    invoke _draw_grass, 10, 12, frame_time
    invoke _draw_grass, 10, 13, frame_time

    ret
_draw_final ENDP


end