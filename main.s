.text

.include "macros.s"
main:

    call apresentacao_inicial
    call limpar_tela
    
    li s0,0 # S0 = GolsBrasil
    li s1,0 # s1 = GolsFranca
    li s2,0 # s2 = Indicador que indica o time com a posse atual, 0 para Brasil 1 para França
    li t3,6 # t3 = Posição atual do jogador com a bola (começa no meio campo)
    li t4, 0 # t4 = Posição alvo de passe,0 indica chute ao gol
    loop_jogo:
    	posse_jogador:
    		call mostrar_opcoes # Mostra as opções de passe do usuário 
    		call acao_player # Realiza a ação que o player digitar
    		#retorna 0 caso passe completo, 1 caso gol,2 caso passe incompleto ou chute falhou
    		li t0,0
    		beq a0,t0,posse_jogador
    		li t0,1
    		beq a0,t0,posse_jogador_gol
    		li t0,2
    		beq a0,t0,troca_de_posse_jogador_maquina
    		posse_jogador_gol:
    			addi s0,s0,1
    			j fim_posse_jogador
    		troca_de_posse_jogador_maquina:
    			li s2,1
    			j fim_posse_jogador
    	fim_posse_jogador:
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
.include "funcoes_jogadores.s"

