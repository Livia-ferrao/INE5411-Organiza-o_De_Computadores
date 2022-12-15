.data

.text
.globl main
main: 
	jal ler_inteiro_teclado # chama funcao para ler
	move $a0, $v0
	jal ler_inteiro_teclado # chama funcao para ler
	move $a1, $v0
	jal calcular_raiz
	move $a0, $v0
	jal imprime_inteiro # imprime numero lido
	j fim
	
calcular_raiz:
	not $t0, $a1 # not B
	addi $t0, $t0, 1  # soma 1
	div $t1, $t0, $a0  # (-b/a)
	move $v0, $t1
	jr $ra 

ler_inteiro_teclado:
	li $v0, 5 # codigo para ler um inteiro
	syscall # chama SO para ler
	jr $ra # volta para o lugar de onde foi chamado

imprime_inteiro:
	li $v0, 1 # codigo para imprimir inteiro
	syscall
	jr $ra

fim:
	li $v0, 10 #codigo encerrar programa
	syscall