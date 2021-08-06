.data
blank : .asciiz " "
_4sc : .asciiz "after bubble sort:\n"
_2sc : .asciiz "before bubble sort:\n"
_1sc : .asciiz "please input ten int number for bubble sort:\n"
_3sc : .asciiz "\n"
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
main:
	subu $sp, $sp, 88
	la $25, _1sc
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	li $25, 0
	move $24, $25
_1LoopCheckLabel:
	li $25, 10
	slt $23, $24, $25
	move $25, $23
	beq $25, $0, _1LoopEndLabel
	li $23, 0
	add $23, $23, $24
	mul $23, $23, 4
	li $25, 0
	add $23, $23, $25
	sw $23, -68($fp)
	sw $24, -44($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	jal Mars_GetInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $23, -68($fp)
	lw $24, -44($fp)
	move $25, $2
	subu $v1, $fp, $23
	subu $v1, $v1, 4
	sw $25, ($v1)
_1LoopStepLabel:
	li $23, 1
	add $24, $24, $23
	j _1LoopCheckLabel
_1LoopEndLabel:
	la $24, _2sc
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $24
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	li $23, 0
	move $24, $23
_2LoopCheckLabel:
	li $23, 10
	slt $25, $24, $23
	move $23, $25
	beq $23, $0, _2LoopEndLabel
	li $25, 0
	add $25, $25, $24
	mul $25, $25, 4
	li $23, 0
	add $25, $25, $23
	subu $25, $fp, $25
	subu $25, $25, 4
	lw $25, ($25)
	sw $24, -48($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal Mars_PrintInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $24, -48($fp)
_2LoopStepLabel:
	li $23, 1
	add $24, $24, $23
	j _2LoopCheckLabel
_2LoopEndLabel:
	la $24, _3sc
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $24
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	li $23, 0
	move $24, $23
_3LoopCheckLabel:
	li $23, 10
	slt $25, $24, $23
	move $23, $25
	beq $23, $0, _3LoopEndLabel
	li $25, 0
	move $23, $25
_4LoopCheckLabel:
	li $25, 10
	sub $22, $25, $24
	move $25, $22
	li $22, 1
	sub $21, $25, $22
	move $25, $21
	slt $22, $23, $25
	move $21, $22
	beq $21, $0, _4LoopEndLabel
	li $21, 0
	add $21, $21, $23
	mul $21, $21, 4
	li $22, 0
	add $21, $21, $22
	subu $21, $fp, $21
	subu $21, $21, 4
	lw $21, ($21)
	li $22, 1
	add $25, $23, $22
	move $22, $25
	li $25, 0
	add $25, $25, $22
	mul $25, $25, 4
	li $22, 0
	add $25, $25, $22
	subu $25, $fp, $25
	subu $25, $25, 4
	lw $25, ($25)
	sgt $22, $21, $25
	move $25, $22
	beq $25, $0, _1otherwise1
	li $25, 0
	add $25, $25, $23
	mul $25, $25, 4
	li $22, 0
	add $25, $25, $22
	subu $25, $fp, $25
	subu $25, $25, 4
	lw $25, ($25)
	move $22, $25
	li $25, 0
	add $25, $25, $23
	mul $25, $25, 4
	li $21, 0
	add $25, $25, $21
	li $21, 1
	add $20, $23, $21
	move $21, $20
	li $20, 0
	add $20, $20, $21
	mul $20, $20, 4
	li $21, 0
	add $20, $20, $21
	subu $20, $fp, $20
	subu $20, $20, 4
	lw $20, ($20)
	subu $v1, $fp, $25
	subu $v1, $v1, 4
	sw $20, ($v1)
	li $20, 1
	add $25, $23, $20
	move $20, $25
	li $25, 0
	add $25, $25, $20
	mul $25, $25, 4
	li $20, 0
	add $25, $25, $20
	subu $v1, $fp, $25
	subu $v1, $v1, 4
	sw $22, ($v1)
	j _1endif
_1otherwise1:
_1endif:
_4LoopStepLabel:
	li $25, 1
	add $23, $23, $25
	j _4LoopCheckLabel
_4LoopEndLabel:
_3LoopStepLabel:
	li $23, 1
	add $24, $24, $23
	j _3LoopCheckLabel
_3LoopEndLabel:
	la $24, _4sc
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $24
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	li $23, 0
	move $24, $23
_5LoopCheckLabel:
	li $23, 10
	slt $25, $24, $23
	move $23, $25
	beq $23, $0, _5LoopEndLabel
	li $25, 0
	add $25, $25, $24
	mul $25, $25, 4
	li $23, 0
	add $25, $25, $23
	subu $25, $fp, $25
	subu $25, $25, 4
	lw $25, ($25)
	sw $24, -64($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal Mars_PrintInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $24, -64($fp)
_5LoopStepLabel:
	li $23, 1
	add $24, $24, $23
	j _5LoopCheckLabel
_5LoopEndLabel:
	li $24, 0
	move $2, $24
	move $sp, $fp
	jr $31
