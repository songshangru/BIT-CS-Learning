ICO_MAIN equ 100
back_ground equ 100
player1_head equ 101
player1_body equ 102
player1_tail equ 103
apple      equ 104
apple_mask equ 105
wall       equ 106
grass      equ 107
emoji      equ 108
player2_head equ 109
player2_body equ 110
player2_tail equ 111
fast         equ 112
large        equ 113
large_mask   equ 114
dizzy        equ 115
dizzy_mask        equ 116
num         equ 117
begin       equ 118
begin_mask  equ 119
key_s equ 53h
key_w equ 57h
key_a equ 41h
key_d equ 44h
key_up equ 26h
key_down equ 28h
key_left equ 25h
key_right equ 27h
window_x_len equ 24
window_y_len equ 14
cell_size equ 50
buffer_size equ 50
large_eat equ 1

draw_struct STRUCT ;绘制的消息
    x dword ?
    y dword ?
    prio dword ?    ;绘制的优先级，蛇头比蛇身和蛇尾优先级高，蛇身比蛇尾优先级高，优先级 1,2,3,4，1最大
    item dword ?    ;绘制的物体
    state dword ?   ;绘制物体的状态，现在只有方向状态，但等以后可能加入死亡动画等等，会加入蛇的正在死亡状态等等
    player dword ?
draw_struct ENDS