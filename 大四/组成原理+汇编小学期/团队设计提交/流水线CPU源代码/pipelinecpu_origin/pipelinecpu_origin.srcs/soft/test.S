    .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
    addi $t1, $t1, -100
    addiu $t2, $t2, 100
    # 数据相关 插入两条空指令
    add $t3, $t1, $t1
    addu $t4, $t2, $t2
    ori	$t5, $t2, 10
    xori $t6, $t2, 10
    andi $t7, $t2, 10
    sub	$s0, $t1, $t2
    subu $s1, $t2, $t1
    # 数据相关 插入三条空指令
    and $s2, $s0, $s1
    or $s3, $s0, $s1
    nor $s4, $s0, $s1
    xor $s5, $s0, $s1
    lui $s6, 0xbfc1
    # 数据相关 插入三条空指令
    sw $s5, ($s6)
    lw $s7, ($s6)
loop:
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    addi $t4, $t4, 1
    addi $t5, $t5, 1
    j loop
    # 控制相关 冲刷流水线 下一条指令不会被执行
    addi $t1, $t1, 100
    
    
