.text

.include "macros.s"
main:

    call apresentacao_inicial
    call limpar_tela
    
    li s0,0 # S0 = GolsBrasil
    li s1,0 # s1 = GolsFranca
    li s2, 0 # s2 = Posse atual, 0 representa posse do brasil e 1 posse da França
    li s3,6 # s3 = Posição atual do jogador com a bola (começa no meio campo)
    loop_jogo:
    	posse_jogador:
    		call mostrar_opcoes # Mostra as opções de passe do usuário 
    		call acao_player # Realiza a ação que o player digitar
    		
    		
    	print("\nATAQUE DA FRANÇA,ESCOLHA ONDE IRÁ DEFENDER")
    	call opcoes_jogador
    	mv t0,a0
        li a0,3 # Define o limite dos numeros sorteados
    	call sortear_numero
    	mv t1,a0
    	call resultado
    	beqz a0,continua_maquina
    	addi s1,s1,1
    	continua_maquina:
    	li a0,3
    	call sleep
    	call limpar_tela
    	call mostrar_resultado
    	li a0,5
    	call sleep
    	li t2,5
    	bge s0,t2,fim
    	bge s1,t2,fim
    	j loop_jogo
    	
fim:	
	li a7,10
	ecall 

.include "funcoes.s"
