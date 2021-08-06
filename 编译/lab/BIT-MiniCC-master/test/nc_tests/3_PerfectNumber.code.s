.data
blank : .asciiz " "
_1sc : .asciiz "The sum is :\n"
_2sc : .asciiz "All perfect numbers within 100:\n"
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
perfectNumber:
	subu $sp, $sp, 404
	li $8, 0
	li $9, 2
	sw $4, 400($sp)
	sw $8, 56($sp)
	sw $9, 68($sp)
IterationCheckL0:
	lw $8, 52($sp)
	lw $9, 68($sp)
	lw $10, 400($sp)
	blt $9, $10, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $8, 52($sp)
	sw $9, 68($sp)
	sw $10, 400($sp)
	lw $8, 52($sp)
	li $25, 0
	beq $8, $25, IterationEndL1
	li $9, 0
	lw $11, 68($sp)
	move $10, $11
	li $12, 1
	sw $8, 52($sp)
	sw $9, 64($sp)
	sw $10, 60($sp)
	sw $11, 68($sp)
	sw $12, 72($sp)
IterationCheckL3:
	lw $8, 40($sp)
	lw $9, 68($sp)
	li $25, 2
	div $9, $25
	mflo $8
	lw $10, 36($sp)
	li $25, 1
	add $10, $8, $25
	lw $11, 32($sp)
	lw $12, 72($sp)
	blt $12, $10, _tmplabel_5
	li $11, 0
	b _tmplabel_7
_tmplabel_5:
	li $11, 1
_tmplabel_7:
	sw $8, 40($sp)
	sw $9, 68($sp)
	sw $10, 36($sp)
	sw $11, 32($sp)
	sw $12, 72($sp)
	lw $8, 32($sp)
	li $25, 0
	beq $8, $25, IterationEndL4
	lw $9, 28($sp)
	lw $10, 68($sp)
	lw $11, 72($sp)
	div $10, $11
	mfhi $9
	lw $12, 24($sp)
	li $25, 0
	beq $9, $25, _tmplabel_9
	li $12, 0
	b _tmplabel_11
_tmplabel_9:
	li $12, 1
_tmplabel_11:
	sw $8, 32($sp)
	sw $9, 28($sp)
	sw $10, 68($sp)
	sw $11, 72($sp)
	sw $12, 24($sp)
	lw $8, 24($sp)
	li $25, 0
	beq $8, $25, IfFalseL6
	lw $10, 64($sp)
	move $9, $10
	addi $10, $10, 1
	li $11, 0
	add $11, $11, $9
	lw $12, 4($sp)
	move $25, $11
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 392
	lw $25, ($24)
	move $12, $25
	lw $13, 72($sp)
	move $12, $13
	move $25, $11
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 392
	sw $12, ($24)
	lw $14, 60($sp)
	sub $14, $14, $13
	sw $8, 24($sp)
	sw $9, 16($sp)
	sw $10, 64($sp)
	sw $11, 8($sp)
	sw $12, 4($sp)
	sw $13, 72($sp)
	sw $14, 60($sp)
	j IfEndL7
IfFalseL6:
IfEndL7:
IterationNextL5:
	lw $9, 72($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 20($sp)
	sw $9, 72($sp)
	j IterationCheckL3
IterationEndL4:
	lw $8, 48($sp)
	li $24, 0
	lw $9, 60($sp)
	beq $24, $9, _tmplabel_13
	li $8, 0
	b _tmplabel_15
_tmplabel_13:
	li $8, 1
_tmplabel_15:
	sw $8, 48($sp)
	sw $9, 60($sp)
	lw $8, 48($sp)
	li $25, 0
	beq $8, $25, IfFalseL8
	sw $8, 48($sp)
	lw $8, 68($sp)
	move $4, $8
	sw $ra, 396($sp)
	jal Mars_PrintInt
	lw $ra, 396($sp)
	lw $10, 56($sp)
	move $9, $10
	addi $10, $10, 1
	sw $8, 68($sp)
	sw $9, 0($sp)
	sw $10, 56($sp)
	j IfEndL9
IfFalseL8:
IfEndL9:
IterationNextL2:
	lw $9, 68($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 44($sp)
	sw $9, 68($sp)
	j IterationCheckL0
IterationEndL1:
	la $24, _1sc
	move $4, $24
	sw $ra, 396($sp)
	jal Mars_PrintStr
	lw $ra, 396($sp)
	lw $8, 56($sp)
	move $4, $8
	sw $ra, 396($sp)
	jal Mars_PrintInt
	lw $ra, 396($sp)
	addu $sp, $sp, 404
	jr $ra
main:
	subu $sp, $sp, 4
	la $24, _2sc
	move $4, $24
	sw $ra, 0($sp)
	jal Mars_PrintStr
	lw $ra, 0($sp)
	li $24, 100
	move $4, $24
	sw $ra, 0($sp)
	jal perfectNumber
	lw $ra, 0($sp)
	li $v0, 0
	addu $sp, $sp, 4
	jr $ra
