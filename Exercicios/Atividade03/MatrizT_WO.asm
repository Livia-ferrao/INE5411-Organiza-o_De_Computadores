.data
Matriz:     	.word 1, 2, 0, 1, -1, -3, 0, 1, 3, 6, 1, 3, 2, 4, 0, 3
MatrizT:     	.space 64
fout:   	.asciiz "MatrizT.dat"      
buffer: 	.asciiz "The quick brown fox jumps over the lazy dog."

.text
.globl teste1
teste1: 
	la $s0, Matriz
	la $s1, MatrizT	
	add $t1, $t1, $s1 	#Posição na Mat T
	
	# Open (for writing) a file that does not exist
  	li   $v0, 13       	# system call for open file
  	la   $a0, fout     	# output file name
  	li   $a1, 1        	# Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        	# mode is ignored
  	syscall            	# open a file (file descriptor returned in $v0)
  	move $s6, $v0      	# save the file descriptor 
	
Loop_j:
	add $t0, $t3, $s0	#Endereço Linha
Loop_i:
	lw $t2, 0($t0) 		#Registra o Valor
	addi $t2, $t2, 48 
	sw $t2, 0($t1) 		#Insere na MemT
	add $t1, $t1, 4		#Muda a posição da Mat
	add $t0, $t0, 16	#Pula a Linha e Registra o Prox Valor...
	addi $t4, $t4, 1	#Contador interno
	
	add	$a0, $zero, $t2	# Valor a ser escrito
	li 	$v0, 1  	# Comando.
	syscall

	li 	$a0, ' '	# Valor a ser escrito
	li	$v0, 11		# Comando
	syscall 
	
	bne $t4, 4, Loop_i
	
	li	$a0, '\n'	
	li	$v0, 11		
	syscall
	
	li $t4, 0
	add $t3, $t3, 4
	bne $t3, 16, Loop_j
	
	# Write to file just opened
  	li   $v0, 15       	# system call for write to file
  	move $a0, $s6      	# file descriptor 
  	la   $a1, MatrizT  	# address of buffer from which to write
  	li   $a2, 36       	# hardcoded buffer length
  	syscall            	# write to file
  	
  	# Close the file 
  	li   $v0, 16       	# system call for close file
  	move $a0, $s6      	# file descriptor to close
  	syscall            	# close file	
