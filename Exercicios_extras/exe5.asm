.data
	A: .word 1
	B: .word 3

.text
.globl main
# slt, sgt, sle, sge
main:
	# EXERCICIO A
	lw $s0, A
	lw $s1, B
	sgt $t0, $s0, $s1    # 1 se for maior
	beq $t0, $0, EXIT     # se $t0 == 0
	addi $s0, $s0, 1

	# EXERCICIO B 
	lw $s0, A
	lw $s1, B
	sge $t0, $s0, $s1       # 1 se for maior igual
	beq $t0, $zero, EXIT    # se $t0 == 0
	addi $s1, $s1, 1
	
	# EXERCICIO c
	lw $s0, A
	lw $s1, B
	sle $t0, $s0, $s1       # 1 se for maior igual
	beq $t0, $zero, EXIT     # se $t0 == 0
	addi $s1, $s1, 1
	
	# EXERCICIO D
	lw $s0, A
	lw $s1, B
	bne $s0, $s1, EXIT 
	move $s1, $s0
	
	# EXERCICIO E
	lw $s0, A
	lw $s1, B
	slt $t0, $s0, $s1 # 1 se for menor
	beq $t0, $zero, ELSE # se $t0 == 0
	addi $s0, $s0, 1
	jal EXIT
	
	ELSE:
	addi $s1, $s1, 1
	jal EXIT
	
	# EXERCICIO F
	addi $s0, $s0, 0 #a
	addi $s1, $s1, 0 #b
	addi $s2, $s2, 5 #c

loop:
	slt $t0, $s0, $s2
	beq $t0, 0, EXIT
	
	addi $s0, $s0, 1
	addi $s1, $s1, 2
	j loop
	
# EXERCICIO F
	addi $s0, $s0, 0 #a
	addi $s1, $s1, 0 #b
	addi $s2, $s2, 5 #c
	bge $s0, $s2, EXIT
loop:
	addi $s0, $s0, 1
	addi $s1, $s1, 2
	blt $s0, $s2, loop
EXIT:
	
	
	# EXERCICIO G
	li $s0, 1
	li $s1, 2
	li $s2, 0  # i
loop:
	bge $s2, 5, EXIT
	addi $s0, $s1, 1
	addi $s1, $s1, 3
	
	addi $s2, $s2, 1
	j loop

	# EXERCICIO H
	li $s0, 1
	li $s1, 2
	li $s2, 3
	
	beq $s0, 1, case1
	beq $s0, 2, case2
	move $s1, $s2
	j EXIT

case1:
	addi $s1, $s2, 1
	j EXIT
case2: 
	addi $s1, $s2, 2
	j EXIT
		
EXIT:
