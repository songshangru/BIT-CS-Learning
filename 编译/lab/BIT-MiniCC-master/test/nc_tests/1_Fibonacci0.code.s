.data
blank : .asciiz " "
_1sc : .asciiz "Please input a number:\n"
_2sc : .asciiz "This number's fibonacci value is :\n"
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
fibonacci:
	subu $sp, $sp, 32
	move $25, $4
	li $24, 1
	slt $23, $25, $24
	move $24, $23
	beq $24, $0, _1otherwise1
	li $23, 0
	move $24, $23
	j _1endif
_1otherwise1:
	li $23, 2
	sle $22, $25, $23
	move $23, $22
	beq $23, $0, _1otherwise2
	li $22, 1
	move $24, $22
	j _1endif
_1otherwise2:
	li $23, 1
	sub $22, $25, $23
	move $23, $22
	sw $25, -4($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $23
	jal fibonacci
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $25, -4($fp)
	move $22, $2
	li $23, 2
	sub $21, $25, $23
	move $25, $21
	sw $22, -12($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal fibonacci
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $22, -12($fp)
	move $25, $2
	add $21, $22, $25
	move $22, $21
	move $24, $22
_1endif:
	move $2, $24
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
	jal fibonacci
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
