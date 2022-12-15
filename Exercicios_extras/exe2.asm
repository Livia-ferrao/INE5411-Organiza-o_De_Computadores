.data
	I: .word 1
	
.text
.globl main
main:
	li $t1, 1
	jal somar
	j EXIT
somar:
	add $t2, $t2, $t1
	addi $s5, $s5, 1
	add $t1, $t1, 1
	ble $t1, 5, somar
	jr $ra
	
EXIT: