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
	subu $sp, $sp, 24
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
	la $25, _1sc
	sw $24, -4($fp)
	subu $sp, $sp, 4
	sw $fp, ($sp)
	move $fp, $sp
	sw $31, 20($sp)
	move $4, $25
	jal Mars_PrintStr
	lw $31, 20($sp)
	lw $fp, ($sp)
	addu $sp, $sp, 4
	lw $24, -4($fp)
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
