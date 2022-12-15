.data
	valores: .word 1 3 2 1 4 5
.text
.globl main
main:
	la $s0, 0x10010020
	la $s1, valores
	
loop:
	lw $s2, 0($s1)	
	sw $s2, 0($s0)
	
	addi $s1, $s1, 4
	addi $s0, $s0, 4   # $s0 é o i
	
	addi $s5, $s5, 1
	bne $s5, 6, loop
	jal EXIT
EXIT:
	add $s3, $zero, 10

