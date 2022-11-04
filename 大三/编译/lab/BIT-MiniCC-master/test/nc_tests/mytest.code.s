.data
blank : .asciiz " "
_1sc : .asciiz "This number's fibonacci value is :\n"
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
	subu $sp, $sp, 172
	li $8, 0
	sw $8, 60($sp)
IterationCheckL0:
	lw $8, 56($sp)
	lw $9, 60($sp)
	li $25, 5
	blt $9, $25, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $8, 56($sp)
	sw $9, 60($sp)
	lw $8, 56($sp)
	li $25, 0
	beq $8, $25, IterationEndL1
	li $9, 0
	sw $8, 56($sp)
	sw $9, 48($sp)
IterationCheckL3:
	lw $8, 44($sp)
	lw $9, 48($sp)
	li $25, 5
	blt $9, $25, _tmplabel_5
	li $8, 0
	b _tmplabel_7
_tmplabel_5:
	li $8, 1
_tmplabel_7:
	sw $8, 44($sp)
	sw $9, 48($sp)
	lw $8, 44($sp)
	li $25, 0
	beq $8, $25, IterationEndL4
	li $9, 0
	lw $10, 40($sp)
	lw $11, 60($sp)
	li $25, 5
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 48($sp)
	add $9, $9, $12
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	lw $25, ($24)
	lw $13, 32($sp)
	move $13, $25
	move $13, $11
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	sw $13, ($24)
	sw $8, 44($sp)
	sw $9, 36($sp)
	sw $10, 40($sp)
	sw $11, 60($sp)
	sw $12, 48($sp)
	sw $13, 32($sp)
IterationNextL5:
	lw $9, 48($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 28($sp)
	sw $9, 48($sp)
	j IterationCheckL3
IterationEndL4:
IterationNextL2:
	lw $9, 60($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 52($sp)
	sw $9, 60($sp)
	j IterationCheckL0
IterationEndL1:
	la $24, _1sc
	move $4, $24
	sw $ra, 168($sp)
	jal Mars_PrintStr
	lw $ra, 168($sp)
	li $8, 0
	sw $8, 60($sp)
IterationCheckL6:
	lw $8, 24($sp)
	lw $9, 60($sp)
	li $25, 5
	blt $9, $25, _tmplabel_9
	li $8, 0
	b _tmplabel_11
_tmplabel_9:
	li $8, 1
_tmplabel_11:
	sw $8, 24($sp)
	sw $9, 60($sp)
	lw $8, 24($sp)
	li $25, 0
	beq $8, $25, IterationEndL7
	li $9, 0
	sw $8, 24($sp)
	sw $9, 48($sp)
IterationCheckL9:
	lw $8, 16($sp)
	lw $9, 48($sp)
	li $25, 5
	blt $9, $25, _tmplabel_13
	li $8, 0
	b _tmplabel_15
_tmplabel_13:
	li $8, 1
_tmplabel_15:
	sw $8, 16($sp)
	sw $9, 48($sp)
	lw $8, 16($sp)
	li $25, 0
	beq $8, $25, IterationEndL10
	li $9, 0
	lw $10, 12($sp)
	lw $11, 60($sp)
	li $25, 5
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 48($sp)
	add $9, $9, $12
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	lw $25, ($24)
	lw $13, 4($sp)
	move $13, $25
	move $14, $13
	sw $8, 16($sp)
	sw $9, 8($sp)
	sw $10, 12($sp)
	sw $11, 60($sp)
	sw $12, 48($sp)
	sw $13, 4($sp)
	sw $14, 64($sp)
	lw $8, 64($sp)
	move $4, $8
	sw $ra, 168($sp)
	jal Mars_PrintInt
	lw $ra, 168($sp)
	sw $8, 64($sp)
IterationNextL11:
	lw $9, 48($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 0($sp)
	sw $9, 48($sp)
	j IterationCheckL9
IterationEndL10:
IterationNextL8:
	lw $9, 60($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 20($sp)
	sw $9, 60($sp)
	j IterationCheckL6
IterationEndL7:
	li $2, 0
	addu $sp, $sp, 172
	jr $ra
