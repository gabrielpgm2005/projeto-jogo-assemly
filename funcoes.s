#========================================================
#               DEFINICAO DAS FUNCOES
#========================================================
.text 
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
	print("Minuto: ")
	li a7,1
	mv a0,s3
	ecall
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
mostrar_opcoes:
	print("\n(0) Chutar da posição atual\n")
	print("\n(1) Alisson\n")
	print("\n(2) Alex Sandro\n")
	print("\n(3) Leo Pereira\n")
	print("\n(4) Marquinhos\n")
	print("\n(5) Danilo\n")
	print("\n(6) Casemiro\n")
	print("\n(7) Paqueta\n")
	print("\n(8) Bruno Guimarães\n")
	print("\n(9) Endrick\n")
	print("\n(10) Neymar\n")
	print("\n(11) Rayan\n")
	ret
acao_player:
	push(ra)
	print("\nEscolha sua opção!\n")
	li  a7, 5
	ecall
	mv t4,a0
	bnez t4,passe
	beqz t4,chute
	
	passe:
		call funcao_passe
		j fim_acao_player
	chute:
		call funcao_chute
		j fim_acao_player
	fim_acao_player:
	pop(ra)
	ret
# Simulação de um switch case para chamar a função correta com base na posição atual
funcao_passe:
	push(ra)
	li a0,0 # Para as funções de Jogadores saberem que se trata de um passe
	li t1,1
	beq t3,t1,passe_goleiro
	li t1,6
	blt t3,t1,passe_zaga
	li t1,9
	blt t3,t1,passe_meio_campo
	j passe_atacante
	passe_goleiro:
		call funcao_goleiro
		j fim_funcao_passe
	passe_zaga:
		call funcao_zaga
		j fim_funcao_passe
	passe_meio_campo:
		call funcao_meio_campo
		j fim_funcao_passe
	passe_atacante:
		call funcao_atacante
	fim_funcao_passe:
	pop(ra)
	ret
funcao_chute:
	push(ra)
	li a0,1 # Para as funções de Jogadores saberem que se trata de um chute
	li t1,1
	beq t0,t1,chute_goleiro
	li t1,6
	blt t0,t1,chute_zaga
	li t1,9
	blt t0,t1,chute_meio_campo
	j chute_atacante
	chute_goleiro:
		call funcao_goleiro
		j fim_funcao_chute
	chute_zaga:
		call funcao_zaga
		j fim_funcao_chute
	chute_meio_campo:
		call funcao_meio_campo
		j fim_funcao_chute
	chute_atacante:
		call funcao_atacante
	fim_funcao_chute:
	pop(ra)
	ret
# Função que calcula probabilidades do tipo x/y
# a2 = x e a3 = y
# Retorna 1 em caso de sucesso, 0 em caso de fracasso
calculadora_de_probabilidade:
	push(ra)
	mv a0,a3
	call sortear_numero
	ble a0,a2,acertou_calculadora_de_probabilidade
	j errou_calculadora_de_probabilidade
	acertou_calculadora_de_probabilidade:
		li a0,1
		j fim_calculadora_de_probabilidade
	errou_calculadora_de_probabilidade:
		li a0,0
	fim_calculadora_de_probabilidade:
	pop(ra)
	ret
resultado_passe:
	beqz a0,errou_passe
	print("\nPasse Completo!\n")
	mv t3,t4
	li a0,0 # Retorna para o main o status de passe completo
	j fim_resultado_passe
	errou_passe:
		print("\nO PASSE FOI INTERCEPTADO, A POSSE PASSA PARA O TIME ADVERSÁRIO\n")
		li a0,2 # Retorna para o main o status que ouve troca de posse
	fim_resultado_passe:
	ret
resultado_chute:
	beqz a0,errou_chute
	print("\nGOOOOOOOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLL\n")
	li a0,1 # Retorna para o main o status que ouve gol 
	j fim_resultado_chute
	errou_chute:
		print("\n O GOLEIRO DEFENDEEE\nA BOLA FICA COM O ADVERSARIO\n")
		li a0,2 # Retorna para o main o status que ouve troca de posse
	fim_resultado_chute:
	ret
		

	
		
	
	
	
		
	
	
		
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
