.data
blank : .asciiz " "
_1sc : .asciiz "\n"
.text
__init:
	lui $sp, 0x8000
	addi $sp, $sp, 0x0000
	move $fp, $sp
	add $gp, $gp, 0x8000
	jal main
	li $v0, 10
	syscall
Mars_PrintInt:
	li $v0, 1
	syscall
	li $v0, 4
	move $v1, $a0
	la $a0, blank
	syscall
	move $a0, $v1
	jr $ra
Mars_GetInt:
	li $v0, 5
	syscall
	jr $ra
Mars_PrintStr:
	li $v0, 4
	syscall
	jr $ra
YangHuiTriangle:
	subu $sp, $sp, 388
	li $8, 0
	sw $8, 380($sp)
IterationCheckL0:
	lw $8, 116($sp)
	lw $9, 380($sp)
	li $25, 8
	blt $9, $25, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $8, 116($sp)
	sw $9, 380($sp)
	lw $8, 116($sp)
	li $25, 0
	beq $8, $25, IterationEndL1
	li $9, 0
	sw $8, 116($sp)
	sw $9, 376($sp)
IterationCheckL3:
	lw $8, 108($sp)
	lw $9, 376($sp)
	li $25, 8
	blt $9, $25, _tmplabel_5
	li $8, 0
	b _tmplabel_7
_tmplabel_5:
	li $8, 1
_tmplabel_7:
	sw $8, 108($sp)
	sw $9, 376($sp)
	lw $8, 108($sp)
	li $25, 0
	beq $8, $25, IterationEndL4
	li $9, 0
	lw $10, 104($sp)
	lw $11, 380($sp)
	li $25, 8
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 376($sp)
	add $9, $9, $12
	lw $13, 96($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	lw $25, ($24)
	move $13, $25
	li $13, 1
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	sw $13, ($24)
	sw $8, 108($sp)
	sw $9, 100($sp)
	sw $10, 104($sp)
	sw $11, 380($sp)
	sw $12, 376($sp)
	sw $13, 96($sp)
IterationNextL5:
	lw $9, 376($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 92($sp)
	sw $9, 376($sp)
	j IterationCheckL3
IterationEndL4:
IterationNextL2:
	lw $9, 380($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 112($sp)
	sw $9, 380($sp)
	j IterationCheckL0
IterationEndL1:
	li $8, 2
	sw $8, 380($sp)
IterationCheckL6:
	lw $8, 88($sp)
	lw $9, 380($sp)
	li $25, 8
	blt $9, $25, _tmplabel_9
	li $8, 0
	b _tmplabel_11
_tmplabel_9:
	li $8, 1
_tmplabel_11:
	sw $8, 88($sp)
	sw $9, 380($sp)
	lw $8, 88($sp)
	li $25, 0
	beq $8, $25, IterationEndL7
	li $9, 1
	sw $8, 88($sp)
	sw $9, 376($sp)
IterationCheckL9:
	lw $8, 80($sp)
	lw $9, 376($sp)
	lw $10, 380($sp)
	blt $9, $10, _tmplabel_13
	li $8, 0
	b _tmplabel_15
_tmplabel_13:
	li $8, 1
_tmplabel_15:
	sw $8, 80($sp)
	sw $9, 376($sp)
	sw $10, 380($sp)
	lw $8, 80($sp)
	li $25, 0
	beq $8, $25, IterationEndL10
	li $9, 0
	lw $10, 76($sp)
	lw $11, 380($sp)
	li $25, 8
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 376($sp)
	add $9, $9, $12
	lw $13, 68($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	lw $25, ($24)
	move $13, $25
	lw $14, 64($sp)
	li $25, 1
	sub $14, $11, $25
	li $15, 0
	sw $8, 80($sp)
	lw $8, 60($sp)
	li $25, 8
	mul $8, $14, $25
	add $15, $15, $8
	add $15, $15, $12
	sw $9, 72($sp)
	lw $9, 52($sp)
	move $25, $15
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	lw $25, ($24)
	move $9, $25
	sw $10, 76($sp)
	lw $10, 48($sp)
	li $25, 1
	sub $10, $12, $25
	sw $11, 380($sp)
	lw $11, 44($sp)
	sw $13, 68($sp)
	lw $13, 380($sp)
	li $25, 1
	sub $11, $13, $25
	sw $12, 376($sp)
	li $12, 0
	sw $14, 64($sp)
	lw $14, 40($sp)
	li $25, 8
	mul $14, $11, $25
	add $12, $12, $14
	add $12, $12, $10
	sw $15, 56($sp)
	lw $15, 32($sp)
	move $25, $12
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	lw $25, ($24)
	move $15, $25
	sw $8, 60($sp)
	lw $8, 68($sp)
	add $8, $9, $15
	sw $13, 380($sp)
	lw $13, 72($sp)
	move $25, $13
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	sw $8, ($24)
	sw $8, 68($sp)
	sw $9, 52($sp)
	sw $10, 48($sp)
	sw $11, 44($sp)
	sw $12, 36($sp)
	sw $13, 72($sp)
	sw $14, 40($sp)
	sw $15, 32($sp)
IterationNextL11:
	lw $9, 376($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 28($sp)
	sw $9, 376($sp)
	j IterationCheckL9
IterationEndL10:
IterationNextL8:
	lw $9, 380($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 84($sp)
	sw $9, 380($sp)
	j IterationCheckL6
IterationEndL7:
	li $8, 0
	sw $8, 380($sp)
IterationCheckL12:
	lw $8, 24($sp)
	lw $9, 380($sp)
	li $25, 8
	blt $9, $25, _tmplabel_17
	li $8, 0
	b _tmplabel_19
_tmplabel_17:
	li $8, 1
_tmplabel_19:
	sw $8, 24($sp)
	sw $9, 380($sp)
	lw $8, 24($sp)
	li $25, 0
	beq $8, $25, IterationEndL13
	li $9, 0
	sw $8, 24($sp)
	sw $9, 376($sp)
IterationCheckL15:
	lw $8, 16($sp)
	lw $9, 376($sp)
	lw $10, 380($sp)
	ble $9, $10, _tmplabel_21
	li $8, 0
	b _tmplabel_23
_tmplabel_21:
	li $8, 1
_tmplabel_23:
	sw $8, 16($sp)
	sw $9, 376($sp)
	sw $10, 380($sp)
	lw $8, 16($sp)
	li $25, 0
	beq $8, $25, IterationEndL16
	li $9, 0
	lw $10, 12($sp)
	lw $11, 380($sp)
	li $25, 8
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 376($sp)
	add $9, $9, $12
	lw $13, 4($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 372
	lw $25, ($24)
	move $13, $25
	sw $8, 16($sp)
	sw $9, 8($sp)
	sw $10, 12($sp)
	sw $11, 380($sp)
	sw $12, 376($sp)
	sw $13, 4($sp)
	lw $8, 4($sp)
	move $4, $8
	sw $ra, 384($sp)
	jal Mars_PrintInt
	lw $ra, 384($sp)
	sw $8, 4($sp)
IterationNextL17:
	lw $9, 376($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 0($sp)
	sw $9, 376($sp)
	j IterationCheckL15
IterationEndL16:
	la $24, _1sc
	move $4, $24
	sw $ra, 384($sp)
	jal Mars_PrintStr
	lw $ra, 384($sp)
IterationNextL14:
	lw $9, 380($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 20($sp)
	sw $9, 380($sp)
	j IterationCheckL12
IterationEndL13:
	addu $sp, $sp, 388
	jr $ra
main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	jal YangHuiTriangle
	lw $ra, 0($sp)
	li $v0, 0
	addu $sp, $sp, 4
	jr $ra
