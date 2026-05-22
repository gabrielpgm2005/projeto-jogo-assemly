#========================================================
#               DEFINICAO DAS FUNCOES
#========================================================
.text 
	.globl apresentacao_inicial sleep limpar_tela opcoes_jogador sortear_numero resultado mostrar_resultado
apresentacao_inicial:
	push(ra)
	print("\nBEM VINDO(A) AO INCRÍVEL SIMULADOR DE FINAL DE COPA DO MUNDO\n")
	li a0,6
	call sleep
	print("\nMOSTRE QUE VOCÊ PODE TRAZER O HEXA PARA CASA!\n")
	li a0,6
	call sleep
    	pop(ra)
    	ret
    
sleep:
	li t0,1000
	mul a0,a0,t0
	
	li a7,32
	ecall
	
	ret
	
limpar_tela:
        li t0, 60
	loop_limpa_tela:
	    li a7, 11
	    li a0, '\n'
	    ecall
	    addi t0, t0, -1
	    bnez t0, loop_limpa_tela
	ret
	    
opcoes_jogador:
	print("\nPressione (1) para escolher o lado direito\n")
	print("\nPressione (2) para escolher o meio\n")
	print("\nPressione (3) para escolher o lado esquerdo\n")
	li a7,5
	ecall
	ret
	
sortear_numero:

	mv t0,a0 # Salva o limite em t0
	
	li a7,30
	ecall
	
	mv a1,a0
	li a7,40
	li a0,0
	ecall
	
	li a7,42
	li a0,0
	mv a1,t0
	ecall
	
	addi a0,a0,1
	ret
resultado:

	beq a0,a1,acertou
	bne a0,a1,errou
	acertou:
		print("\nGOOOOOOLLLLL\n")
		li a0,1
		j step
	errou:
		print("O GOLEIRO ACERTOU O LADO")
		li a0,0
	step:
		ret
mostrar_resultado:
	print("\n Brasil:")
	mv a0,s0
	li a7,1
	ecall
	print(" x ")
	li a7,1
	mv a0,s1
	ecall
	print(" Franca\n")
	ret