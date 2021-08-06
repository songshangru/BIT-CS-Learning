.data
blank : .asciiz " "
_1sc : .asciiz "Please input a number:\n"
_2sc : .asciiz "The number of prime numbers within n is:\n"
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
	subu $sp, $sp, 60
	li $8, 0
	li $9, 1
	li $10, 2
	sw $4, 56($sp)
	sw $8, 48($sp)
	sw $9, 36($sp)
	sw $10, 44($sp)
IterationCheckL0:
	lw $8, 32($sp)
	lw $9, 44($sp)
	lw $10, 56($sp)
	ble $9, $10, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $8, 32($sp)
	sw $9, 44($sp)
	sw $10, 56($sp)
	lw $8, 32($sp)
	li $25, 0
	beq $8, $25, IterationEndL1
	li $9, 1
	li $10, 2
	sw $8, 32($sp)
	sw $9, 36($sp)
	sw $10, 40($sp)
IterationCheckL3:
	lw $8, 20($sp)
	lw $9, 40($sp)
	mul $8, $9, $9
	lw $10, 16($sp)
	lw $11, 44($sp)
	ble $8, $11, _tmplabel_5
	li $10, 0
	b _tmplabel_7
_tmplabel_5:
	li $10, 1
_tmplabel_7:
	sw $8, 20($sp)
	sw $9, 40($sp)
	sw $10, 16($sp)
	sw $11, 44($sp)
	lw $8, 16($sp)
	li $25, 0
	beq $8, $25, IterationEndL4
	lw $9, 12($sp)
	lw $10, 44($sp)
	lw $11, 40($sp)
	div $10, $11
	mfhi $9
	lw $12, 8($sp)
	li $25, 0
	beq $9, $25, _tmplabel_9
	li $12, 0
	b _tmplabel_11
_tmplabel_9:
	li $12, 1
_tmplabel_11:
	sw $8, 16($sp)
	sw $9, 12($sp)
	sw $10, 44($sp)
	sw $11, 40($sp)
	sw $12, 8($sp)
	lw $8, 8($sp)
	li $25, 0
	beq $8, $25, IfFalseL6
	li $9, 0
	sw $8, 8($sp)
	sw $9, 36($sp)
	j IterationEndL4
	j IfEndL7
IfFalseL6:
IfEndL7:
IterationNextL5:
	lw $9, 40($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 4($sp)
	sw $9, 40($sp)
	j IterationCheckL3
IterationEndL4:
	lw $8, 28($sp)
	lw $9, 36($sp)
	li $25, 1
	beq $9, $25, _tmplabel_13
	li $8, 0
	b _tmplabel_15
_tmplabel_13:
	li $8, 1
_tmplabel_15:
	sw $8, 28($sp)
	sw $9, 36($sp)
	lw $8, 28($sp)
	li $25, 0
	beq $8, $25, IfFalseL8
	lw $10, 48($sp)
	move $9, $10
	addi $10, $10, 1
	sw $8, 28($sp)
	sw $9, 0($sp)
	sw $10, 48($sp)
	lw $8, 44($sp)
	move $4, $8
	sw $ra, 52($sp)
	jal Mars_PrintInt
	lw $ra, 52($sp)
	sw $8, 44($sp)
	j IfEndL9
IfFalseL8:
IfEndL9:
IterationNextL2:
	lw $9, 44($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 24($sp)
	sw $9, 44($sp)
	j IterationCheckL0
IterationEndL1:
	lw $8, 48($sp)
	move $v0, $8
	addu $sp, $sp, 60
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
	jal prime
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
