.data
blank : .asciiz " "
_2sc : .asciiz "The number of prime numbers within n is:\n"
_1sc : .asciiz "Please input a number:\n"
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
prime:
	subu $sp, $sp, 40
	move $25, $4
	li $24, 0
	move $23, $24
	li $24, 1
	li $24, 2
	move $22, $24
_1LoopCheckLabel:
	sle $24, $22, $25
	move $21, $24
	beq $21, $0, _1LoopEndLabel
	li $24, 1
	move $21, $24
	li $24, 2
	move $20, $24
_2LoopCheckLabel:
	mul $24, $20, $20
	move $19, $24
	sle $24, $19, $22
	move $19, $24
	beq $19, $0, _2LoopEndLabel
	rem $24, $22, $20
	move $19, $24
	li $24, 0
	seq $18, $19, $24
	move $19, $18
	beq $19, $0, _1otherwise1
	li $19, 0
	move $21, $19
	j _2LoopEndLabel
	j _1endif
_1otherwise1:
_1endif:
_2LoopStepLabel:
	li $18, 1
	add $20, $20, $18
	j _2LoopCheckLabel
_2LoopEndLabel:
	li $20, 1
	seq $18, $21, $20
	move $21, $18
	beq $21, $0, _2otherwise1
	li $21, 1
	add $23, $23, $21
	sw $23, -8($fp)
	sw $25, -4($fp)
	sw $22, -12($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $22
	jal Mars_PrintInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $23, -8($fp)
	lw $25, -4($fp)
	lw $22, -12($fp)
	j _2endif
_2otherwise1:
_2endif:
_1LoopStepLabel:
	li $18, 1
	add $22, $22, $18
	j _1LoopCheckLabel
_1LoopEndLabel:
	move $2, $23
	move $sp, $fp
	jr $31
main:
	subu $sp, $sp, 28
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
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	jal Mars_GetInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	move $25, $2
	move $24, $25
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $24
	jal prime
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	move $25, $2
	move $24, $25
	la $25, _2sc
	sw $24, -8($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $24, -8($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $24
	jal Mars_PrintInt
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	li $25, 0
	move $2, $25
	move $sp, $fp
	jr $31
