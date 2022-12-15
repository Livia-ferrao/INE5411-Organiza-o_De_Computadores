.data
     	# ENTRADA DE ARQUIVOS
	tam_media: .space 8
	myFile: .asciiz "teste.txt"      # filename for input
	.align 2
	buffer: .space 300
	double_values: .space 200        # 120
	mm3: .space 80
     	mm5: .space 80
     	space: .asciiz "\n"
     	
     	# VALORES PARA PRINTAR NA TELA
     	queda: .asciiz "QUEDA"
     	alta: .asciiz "ALTA"
     	constante: .asciiz "CONSTANTE"
	
	# PARTE 2 - CALULAR DUAS MEDIAS MOVEIS
	str1: .asciiz    "Tamanho da media movel 1 (MENOR): "
     	str2: .asciiz    "Tamanho da media movel 2 (MAIOR): "
     	
     	# STRINGS MEDIA MOVEL
	mm1_string: .asciiz    "MM1: "
     	mm2_string: .asciiz    "MM2: "
     	tendencia_string: .asciiz     "TENDENCIA: "
     	
     	# PRINTS FINAIS
     	menu: .asciiz "====================== MENU ======================="
     	OP1: .asciiz "[1] Cadastrar nova série de dados (arquivo) e exibir na tela "
     	OP2: .asciiz "[2] Calcular a MM-n "
     	OP3: .asciiz "[3] Mostrar série de tendências "
     	menu_fim: .asciiz "========================================================"
     	escolha: .asciiz "ESCOLHA: "
     	     	
.text
menu_principal: 
	# print menu
	la  $a0, menu
    	li $v0,  4
    	syscall
    	jal espaco
    	
    	# print OP1
	la  $a0, OP1
    	li $v0,  4
    	syscall
    	jal espaco
    	    	
    	# print OP2
	la  $a0, OP2
    	li $v0,  4
    	syscall
    	jal espaco
    	
    	# print OP3
	la  $a0, OP3
    	li $v0,  4
    	syscall
    	jal espaco
    	    	
    	# print menu_fim
	la  $a0, menu_fim
    	li $v0,  4
    	syscall
    	jal espaco
    	
    	# print escolha
	la  $a0, escolha
    	li $v0,  4
    	syscall
    	
    	# READ INT 
    	li $v0,  5
    	syscall
	move $t0, $v0   # t0 = escolha
	
	beq $t0, 1, add_ent
    	beq $t0, 2, ler_medias
    	beq $t0, 3, analisar_tend 
    	
add_ent:
    	# LER ARQUIVO
	j open_read_print
		
ler_medias:
	# LER TAMANHO DE MEDIA_MOVEL
	la $s7, tam_media
	jal ler_tamanho_media
	la $s7, tam_media
	jal achar_maior_tam      # resul em $t6
	j menu_principal
	
analisar_tend:	
	# PARA MONTAR NUMERO
	la $s1, buffer
	la $s4, double_values
	li $t2, 10     # 10 dinamico
	li $t4, 10     # 10 estatico
	li $t3, 32     # espaço
	
	# ADICIONAR N ZEROS NA FRENTE (MAIOR NUM)
	jal add_zeros

loop:
	# MONTANDO NUMERO EM DOUBLE 
	jal read_int      
	mov.d $f12, $f0
	s.d $f12, 0($s4)
	l.d $f14, 0($s4)     # TESTAR

	jal reseta_reg
	
	add $s4, $s4, 8
	addi $s5, $s5, 1
	
	bne $s5, 17 , loop   # 16 valores + 1
	
INICIO:	
	# INICIO DA MEDIA MOVEL
	la $s7, tam_media        # 3 e 5

	la $s5, mm3
	lw $t0, 0($s7)
	move $a0, $t6            # maior valor em a0
	move $a1, $t0            # mm3 = 3
	jal media

	la $s5, mm5
	lw $t0, 4($s7)
	move $a0, $t6            # maior valor em a0
	move $a1, $t0            # mm5 = 5
	jal media
	# jal TESTE_PRINT        # Para TESTE
	jal comp
	j EXIT

# ============ LE ARQUIVO E PRINTA ================
open_read_print:
	# Open file for reading
	li   $v0, 13          # system call for open file
	la   $a0, myFile      # input file name
	li   $a1, 0           # flag for reading
	li   $a2, 0           # mode is ignored
	syscall               # open a file 
	move $s0, $v0         # save the file descriptor  

	# reading from file just opened
	li   $v0, 14        # system call for reading from file
	move $a0, $s0       # file descriptor 
	la   $a1, buffer    # address of buffer from which to read
	li   $a2, 1000       # hardcoded buffer length
	syscall             # read from file

	# Printing File Content
	li  $v0, 4          # system Call for PRINT STRING
	la  $a0, buffer     # buffer contains the values
	syscall             # print int
	jal espaco
	j menu_principal

# ========== ADICIONA ZEROS ===========
add_zeros:
	li $t8, 0
	mtc1 $t8, $f12
	s.d $f12, 0($s4)     # guarda 5 zeros
	add $s4, $s4, 8
	add $t9, $t9, 1
	
	bne $t9, $t6, add_zeros
	jr $ra
	
reseta_reg:
	add $s1, $s1, 3 # prox numero
	li $t2, 10     # 10 dinamico
	jr $ra

# ========== LER INTEIRO E DECIMAL ==========
read_int:
	lb $t0, 0($s1)
	addi $t0, $t0, -48   # numero inteiro em t0: 4
	
	mtc1 $t0, $f0      # em f0 está o numero inteiro
	cvt.d.w $f0, $f0
	
	add $s1, $s1, 1    # pula o ponto

read_decimal:
	add $s1, $s1, 1
	lb $t1, 0($s1)
	beq $t1, $t3, voltar      # se for espaco termina
	addi $t1, $t1, -48
	
	mtc1 $t1, $f2        # valor a ser dividido em f2
	cvt.d.w $f2, $f2
	mtc1 $t2, $f4        # 10, dps 100, dps 1000 em f4
	cvt.d.w $f4, $f4
	
	div.d $f6,$f2,$f4
	
	add.d $f0, $f0, $f6   # valor final em f0
	
	mult $t2, $t4         # 10 * 10, dps 100 * 10...
	mflo $t2
	j read_decimal
	
voltar: 
	jr $ra
	
# ============== LER TAMANHO MEDIA ==============
ler_tamanho_media:	
	# PRINT QUEBRA DE LINHA
	li $v0, 4      
    	la $a0, space
    	syscall
    	
    	beq $t5, 1, prox
	# PRINT STRING 1
	la  $a0, str1
    	li $v0,  4
    	syscall
    	j ler_int
    	
prox: 	
	# PRINT STRING 2
	la  $a0, str2
    	li $v0,  4
    	syscall
	
ler_int: 
	# READ INT 
    	li $v0,  5
    	syscall
	move $t0, $v0        # $t0 está a MM3 e MM5
	sw $t0, 0($s7)
		
	add $t5, $t5, 1
	add $s7, $s7, 4
	bne $t5, 2, ler_tamanho_media
	jr $ra

# ========== LER MAIOR TAMANHO DE MM ============
achar_maior_tam:
	lw $s5, 0($s7)
	lw $s6, 4($s7)
	bgt $s5, $s6, retorna_primeiro
	add $t6, $s6 $zero                # SEGUNDO VALOR É MAIOR
	jr $ra
retorna_primeiro:
	add $t6, $s5 $zero                # PRIMEIRO VALOR É MAIOR
	jr $ra


# ============= CALCULAR MEDIA =============
media:
li $t4, 0               # contador interno
li $t5, 0               # contador externo
la $s4, double_values

mtc1 $a0, $f20     # numero maximo
cvt.d.w $f20, $f20
mtc1 $a1, $f22      # tamanho media movel (3 ou 5)
cvt.d.w $f22, $f22
mtc1 $zero, $f24

mul $a0, $a0, 8           # 5*8 = 40
add $s4, $s4, $a0         # começa do quinto valor

li $t9, 1
mtc1 $t9, $f18   # $f18 - auxiliar (n)
cvt.d.w $f18, $f18
mov.d $f16, $f18  # $f16 = 1

media_movel:
media_movel_dentro:	
	l.d $f0, 0($s4)           # começa do quinto
	add.d $f30, $f30, $f0     # f30 é a soma
	
	sub $s4, $s4, 8
	add $t4, $t4, 1
	bne $t4, $a1, media_movel_dentro # enquanto contador for diferente do numero
	
	div.d $f20, $f30, $f18  # divide soma pelo auxiliar (f28 - resultado)
	s.d $f20, 0($s5)
	addi $s5, $s5, 8
	
	mov.d $f30, $f24        # zera a soma
	li $t4, 0               # reseta contador interno
	
	li $t7, 8
	mul $t7, $t7, $a1     # proximo valor (8*3 + 8) (8*5 + 8)
	addi $t7, $t7, 8
	add $s4, $s4, $t7
	
	c.eq.d $f18, $f22      # se aux == numero, não executa
	bc1t continue
	add.d $f18, $f18, $f16
continue:	
	add $t5, $t5, 1
	bne $t5, 10, media_movel
	
# ============== TESTE ===============
TESTE_PRINT:
	la $s5, mm3
	la $s5, mm5
	
	l.d $f0, 0($s5)
	l.d $f2, 8($s5)
	l.d $f4, 16($s5)
	l.d $f6, 24($s5)
	l.d $f8, 32($s5)
	l.d $f10, 40($s5)
	l.d $f12, 48($s5)
	l.d $f14, 56($s5)
	l.d $f16, 64($s5)
	l.d $f18, 72($s5)
	
	jr $ra

# ===========  COMPARACOES  ==============
comp:
li $t5, 0    # contador interno
la $s0, mm3
la $s1, mm5
li $t0, 0    # QUEDA
li $t1, 0    # ALTA
li $t2, 0    # TENDENCIA
tendencia:	
	l.d $f0, 0($s0)   # m_3
	l.d $f2, 0($s1)   # m_5
if1:
	c.lt.d $f2, $f0  # se o m_5 < m_3 FALSO
	bc1f elif
	bne $t0, 0, elif   # se o $t0 for diferente de 0 FALSO
	
	li $t0, 1
	li $t1, 0
	li $t2, 1
	j print
elif:	
	c.lt.d $f0, $f2  # se m_3 < m_5 FALSO
	bc1f else
	bne $t1, 0, else  # se $t0 for diferente de 0 FALSO
	
	li $t0, 0
	li $t1, 1
	li $t2, 2
	j print

else:
	li $t2, 0        # TENDENCIA = 0


# PRINTAR VALORES
print: 
	#print string (M_3)
	la  $a0, mm1_string
    	li $v0,  4
    	syscall
	
	#printar valores (M_3)
	li $v0, 3
	mov.d $f12, $f0
	syscall
	jal espaco
	
	#print string (M_5)
	la  $a0, mm2_string
    	li $v0,  4
    	syscall
    	
	#printar valores (M_5)
	li $v0, 3
	mov.d $f12, $f2
	syscall
	jal espaco
	
	#print tendencia
	la  $a0, tendencia_string
    	li $v0,  4
    	syscall
	
	beq $t2, 0, const
	beq $t2, 1, alt
	beq $t2, 2, qued
const:	
	#printar tendencia 
	la $a0, constante
    	li $v0,  4
    	syscall
    	jal espaco
    	jal espaco
    	j fim
alt:	
	#printar tendencia
	la $a0, alta
    	li $v0,  4
    	syscall
    	jal espaco
    	jal espaco
    	j fim
qued:
	#printar tendencia
	la $a0, queda
    	li $v0,  4
    	syscall
    	jal espaco
    	jal espaco
    	j fim
 
espaco: 
	# PRINT QUEBRA DE LINHA
	li $v0, 4      
    	la $a0, space
    	syscall
    	jr $ra
	
fim:
	add $s0, $s0, 8  # soma m_3
	add $s1, $s1, 8  # soma m_5
	
	addi $t5, $t5, 1
    	bne $t5, 10, tendencia
	j EXIT
# ===========================================

EXIT:
	li $v0, 10      # Finish the Program
	syscall
