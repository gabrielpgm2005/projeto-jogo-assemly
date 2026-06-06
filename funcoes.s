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
# Recebe como parâmetro o tempo em segundos em a0, multiplica por 1000 pois a syscall 32 recebe o tempo em ms
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
#recebe o limite em a0 e retorna o numero aleatorio em a0	    
sortear_numero:

	mv t0,a0 # Salva o limite em t0
	
	li a7,30 #guarda em a0 o tempo em ms desde 1 de janeiro de 1970
	ecall
	
	#syscall 40 seta a semente para numeros aleatorios
	#parametros: a0 = seleciona qual gerador de numeros aleatorios (0 como padrao)
	#a1 = semente
	mv a1,a0
	li a7,40
	li a0,0
	ecall
	
	#syscall 42 retorna um numero aleatorio em a0 de [0,limite]
	#parametros: a0= index do gerador de numero aleatorio
	# a1 = limite 
	li a7,42
	li a0,0
	mv a1,t0
	ecall
	
	addi a0,a0,1
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
	push(ra)
	print("\ Pressione 0 para chutar a bola da posicao atual\n")
	print("\ Opcoes de passe abaixo\n")
	print("\<Goleiro> n(1) Alisson\n")
	print("\<Zagueiro> n(2) Alex Sandro // n(3) Leo Pereira // n(4) Marquinhos // n(5) Danilo \n")
	print("\<Meio-Campo> n(6) Casemiro // n(7) Paqueta // n(8) Bruno Guimaraes \n")
	print("\<Atacante>n(9) Endrick // n(10) Neymar // n(11) Rayan \n")
	print("A bola está com: ")
	mv a0,t3
	call mostrar_posicao_atual
	pop(ra)
	ret
acao_player:
	push(ra)
	print("\nEscolha se voce ira chutar ou pra quem ira fazer o passe!\n")
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
	#a0 indica para as funcoes de jogadores que se trata de um passe
	li a0,0 
	
	#procuraa funcao correta com base na posicao do jogador
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
	
	#Indica para as funcoes de jogadores que se trata de um chute
	li a0,1 
	
	#Encontra a funcao correta com base na zona do jogador atual
	li t1,1
	beq t3,t1,chute_goleiro
	li t1,6
	blt t3,t1,chute_zaga
	li t1,9
	blt t3,t1,chute_meio_campo
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
calculadora_de_probabilidade:
	push(ra)
	
	#Sorteia um numero de 1 ate o limite
	mv a0,a3
	call sortear_numero
	
	#Verifica se o numero eh menor ou igual ao numero sorteado
	ble a0,a2,acertou_calculadora_de_probabilidade
	j errou_calculadora_de_probabilidade
	
	#retorna o status de 1 em caso de acerto, 0 em caso de fracasso
	acertou_calculadora_de_probabilidade:
		li a0,1
		j fim_calculadora_de_probabilidade
	errou_calculadora_de_probabilidade:
		li a0,0
	fim_calculadora_de_probabilidade:
	pop(ra)
	ret
resultado_passe:
	push(ra)
	#Verifica se o jogador atual esta passando para si mesmo, se sim trata como cera
	beq t3,t4,cera
	
	#Verifica se errou o passe
	beqz a0,errou_passe
	print("\nPasse Completo!\n")
	
	#Mostra uma mensagem de quem esta passando para quem
	mv a0,t3
	call mostrar_posicao_atual
	print(" Passou a bola para ")
	mv a0,t4
	call mostrar_posicao_atual
	print("\n")
	mv t3,t4
	
	j fim_cera
	
	cera:
		#Verifica se errou a cera
		beqz a0,errou_cera
		
		#Mostra o jogador atual em uma mensagem dizendo que esta fazendo cera
		mv a0,t3
		call mostrar_posicao_atual
		print(" Segura a bola e faz cera!\n")
		j fim_cera
		errou_cera:
			print(" Tentou fazer cera, mas perdeu a bola!\n")
			li a0,2
			j fim_resultado_passe
	fim_cera:
	# Retorna para o main o status de passe completo
	li a0,0 
	j fim_resultado_passe
	
	errou_passe:
		#Mostra uma mensagem dizendo que perdeu a posse
		mv a0,t3
		call mostrar_posicao_atual
		print(" PERDDE A BOLA, A POSSE VAI PARA O TIME ADVERSÁRIO!\n")
		
		# Retorna para o main o status que ouve troca de posse
		li a0,2 
	fim_resultado_passe:
	pop(ra)
	ret
resultado_chute:
	push(ra)
	#checa se errou o chute
	beqz a0,errou_chute
	
	#Mensagem em caso de sucesso com o nome do jogador
	print("\nGOOOOOOOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLL\n")
	mv a0,t3
	call mostrar_posicao_atual
	print(" Marca!\n")
	
	# Retorna para o main o status que ouve gol 
	li a0,1 
	j fim_resultado_chute
	
	#Mensagem caso erro do chute
	errou_chute:
		print("\n O GOLEIRO DEFENDEEE\nA BOLA É DO ADVERSÁRIO\n")
		
		# Retorna para o main o status que ouve troca de posse
		li a0,2 
		
	fim_resultado_chute:
	pop(ra)
	ret
# Mostra o nome do jogador que está na posição que foi passada como parâmetro em a0, cuida tanto para o Brasil
#Quanto para a França
mostrar_posicao_atual:
	#subtrai 1 da posição enviada como parametro
	addi a0,a0,-1

    # escolhe qual tabela usar
    beqz s2, mostrar_posicao_atual_brasil

	mostrar_posicao_atual_franca:
    		la t1, tabela_franca
    		j mostrar_posicao_atual_continua

	mostrar_posicao_atual_brasil:
    		la t1, tabela_brasil

	mostrar_posicao_atual_continua:

    	# cada entrada da tabela ocupa 4 bytes, slli move digitos binatior para a esquerda por um imediato especificado
    	#mover 2 bits para a esquerda é o mesmo que multiplicar por 4
    	slli t0, a0, 2
    	add t1, t1, t0
    	
    	#Mostra o nome no indice correto
    	lw a0, 0(t1)
    	li a7, 4
    	ecall

    	ret
mostrar_resultado_penalti:
	print("\nPENALIDADES\n")
	
	#Mostra os gols do Brasil
	print("Brasil: ")
	li a7,1	
	mv a0,s0
	ecall
	
	#Mostra os gols da França
	print(" x França : ")
	li a7,1
	mv a0,s1
	ecall
	print("\n")
	ret
		
	
	
	
		
	
	
		
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
