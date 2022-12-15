.data
	
.text
.globl main
main:
	la $s0, 0x10010020
	
	addi $s1, $s1, 1
	sw $s1, 0($s0)
	
	addi $s2, $s2, 3
	sw $s2, 4($s0)
	
	addi $s3, $s3, 2
	sw $s3, 8($s0)
	
	addi $s4, $s4, 1
	sw $s4, 12($s0)
	
	addi $s5, $s5, 4
	sw $s5, 16($s0)
	
	addi $t0, $t0, 5
	sw $t0, 20($s0)
	
