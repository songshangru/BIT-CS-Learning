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
	subu $sp, $sp, 36
	lw $8, 20($sp)
	li $25, 1
	blt $4, $25, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $4, 32($sp)
	sw $8, 20($sp)
	lw $8, 20($sp)
	li $25, 0
	beq $8, $25, IfFalseL0
	li $9, 0
	sw $8, 20($sp)
	sw $9, 24($sp)
	j IfEndL1
IfFalseL0:
	lw $8, 16($sp)
	lw $9, 32($sp)
	li $25, 2
	ble $9, $25, _tmplabel_5
	li $8, 0
	b _tmplabel_7
_tmplabel_5:
	li $8, 1
_tmplabel_7:
	sw $8, 16($sp)
	sw $9, 32($sp)
	lw $8, 16($sp)
	li $25, 0
	beq $8, $25, IfFalseL2
	li $9, 1
	sw $8, 16($sp)
	sw $9, 24($sp)
	j IfEndL3
IfFalseL2:
	lw $8, 12($sp)
	lw $9, 32($sp)
	li $25, 1
	sub $8, $9, $25
	sw $8, 12($sp)
	sw $9, 32($sp)
	lw $8, 12($sp)
	move $4, $8
	sw $ra, 28($sp)
	jal fibonacci
	lw $ra, 28($sp)
	move $9, $v0
	lw $10, 4($sp)
	lw $11, 32($sp)
	li $25, 2
	sub $10, $11, $25
	sw $8, 12($sp)
	sw $9, 8($sp)
	sw $10, 4($sp)
	sw $11, 32($sp)
	lw $8, 4($sp)
	move $4, $8
	sw $ra, 28($sp)
	jal fibonacci
	lw $ra, 28($sp)
	move $9, $v0
	lw $10, 24($sp)
	lw $11, 8($sp)
	add $10, $11, $9
	sw $8, 4($sp)
	sw $9, 0($sp)
	sw $10, 24($sp)
	sw $11, 8($sp)
IfEndL3:
IfEndL1:
	lw $8, 24($sp)
	move $v0, $8
	addu $sp, $sp, 36
	jr $ra
main:
	subu $sp, $sp, 20
	la $24, _1sc
	move $4, $24
	sw $ra, 16($sp)
	jal Mars_PrintStr
	lw $ra, 16($sp)
	sw $ra, 16($sp)
	jal Mars_GetInt
	lw $ra, 16($sp)
	move $8, $v0
	move $9, $8
	sw $8, 8($sp)
	sw $9, 12($sp)
	lw $8, 12($sp)
	move $4, $8
	sw $ra, 16($sp)
	jal fibonacci
	lw $ra, 16($sp)
	move $9, $v0
	move $10, $9
	sw $8, 12($sp)
	sw $9, 0($sp)
	sw $10, 4($sp)
	la $24, _2sc
	move $4, $24
	sw $ra, 16($sp)
	jal Mars_PrintStr
	lw $ra, 16($sp)
	lw $8, 4($sp)
	move $4, $8
	sw $ra, 16($sp)
	jal Mars_PrintInt
	lw $ra, 16($sp)
	li $v0, 0
	addu $sp, $sp, 20
	jr $ra
