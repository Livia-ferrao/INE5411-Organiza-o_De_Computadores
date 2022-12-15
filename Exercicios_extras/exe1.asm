.data
	A: .word 0
	B: .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
	C: .word 2
	D: .word 3
	E: .word 4
	F: .word 10
.text
.globl main
main:
	#EXERCICIO1 (TESTE)
	la $s1, A
	lw $t0, B
	lw $t1, C
	sub $t0, $t0, $t1
	sw $t0, 0($s1)
	
	# EXERCICIO 1 - A
	la $s0, A
	lw $s1, B
	lw $s2, C
	sub $s3, $s1, $s2
	sw $s3, 24($s0)
	jal limpar_reg
	
	# EXERCICIO 2 - B
	lw $s0, A
	lw $s1, B
	lw $s2, C
	add $s3, $s0, $s1
	sub $s3, $s3, $s2
	sw $s3, D
	jal limpar_reg
	
	# EXERCICIO 3 - C
	lw $s0, A
	lw $s1, B
	lw $s2, D
	add $s3, $s0, $s1
	sub $s3, $s3, $s2
	sw $s3, F
	jal limpar_reg
	
	# EXERCICIO 4 - D
	lw $s0, A
	lw $s1, B
	lw $s2, D
	add $s3, $s1, $s2
	sub $s3, $s0, $s3
	sw $s3, C
	jal limpar_reg
	
	# EXERCICIO 5 - E
	lw $s0, A
	lw $s1, B
	lw $s2, C
	lw $s3, F
	sub $s4, $s1, $s2
	sub $s4, $s0, $s4
	add $s4, $s4, $s3
	sw $s4, E
	jal limpar_reg
	
	# EXERCICIO 6 - F
	lw $s0, A
	lw $s1, B
	lw $s2, C
	lw $s3, E
	sub $s4, $s0, $s1
	sub $s5, $s1, $s2
	mult $s4, $s5
	mflo $s4
	sub $s4, $s3, $s4 
	sw $s4, F
	jal limpar_reg
	
	# EXERCICIO 7 - G
	la $s0, B                
	lw $s1, C
	#addi $s0, $s0, 60    # B[15]  - jeito1
	#lw $s2, 0($s0)
	lw $s2, 60($s0)       # B[15]   - jeito2
	sub $s2, $s2, $s1
	sw $s2, A
	jal limpar_reg
	
	# EXERCICIO 8
	la $s0, A      
	lw $s1, 20($s0)       # A[5]
	la $s2, C
	lw $s3, 12($s2)       # C[3]
	
	add $s4, $s1, $s3	
	sw $s4, B
	jal limpar_reg
	
	# EXERCICIO 9
	la $s5, A
	lw $s0, B
	lw $s1, C
	sub $s2, $s0, $s1
	sw $s2, 40($s5)
	jal limpar_reg
	
	# EXERCICIO 10
	la $s5, B
	lw $s0, A
	lw $s1, C
	add $s2, $s0, $s1
	sw $s2, 980($s5)
	jal limpar_reg
	
	# EXERCICIO 11
	la $s0, A
	la $s1, D
	lw $s2, B
	lw $s3, C
	lw $s5, 268($s1)     # D[67]
	
	sub $s2, $s2, $s3
	add $s2, $s2, $s5
	sw $s2, 180($s0)     # A[45]
	jal limpar_reg
	
	# EXERCICIO 12
	la $s0, A
	la $s1, B
	lw $s2, C
	lw $s3, D
	lw $s5, 72($s2)       # C[18]
	
	sub $s1, $s1, $s5
	add $s1, $s1, $s3
	sw $s1, 316($s0)      # A[79]
	
limpar_reg:
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	jr $ra

EXIT:
