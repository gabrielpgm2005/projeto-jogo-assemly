.text

.include "macros.s"
main:

    call apresentacao_inicial
    call limpar_tela
    
    li s0,0 # S0 = GolsBrasil
    li s1,0 # s1 = GolsFranca
    li s2,0 # s2 = Indicador que indica o time com a posse atual, 0 para Brasil 1 para França
    li s3 0 # s3 = MinutoAtual, guarda o tempo que se passou até agora no jogo, cada ação no jogo dura 1 minuto.
    li t3,6 # t3 = Posição atual do jogador com a bola (começa no meio campo)
    li t4, 0 # t4 = Posição alvo de passe,0 indica chute ao gol
    loop_jogo:
    	posse_jogador:
    		call mostrar_resultado
    		li a0 3
    		call sleep
    		call limpar_tela
    		addi s3,s3,1
    		li t0,90
    		bgt s3,t0,fim_loop
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
    			j posse_maquina
    		troca_de_posse_jogador_maquina:
    			li s2,1
    			j posse_maquina
    	
    	posse_maquina:
    		call mostrar_resultado
    		print("FRANÇA COM A BOLA")
    		li a0 3
    		call sleep
    		call limpar_tela
    		addi s3,s3,1
    		li t0,90
    		bgt s3,t0,fim_loop
    		call rodada_franca
    		li t0,0
    		beq a0,t0,posse_maquina
    		li t0,1
    		beq a0,t0,posse_maquina_gol
    		li t0,2
    		beq a0,t0,troca_de_posse_maquina_jogador
    		posse_maquina_gol:
    			addi s1,s1,1
    			j posse_jogador
    		troca_de_posse_maquina_jogador:
    			li s2,0
    			j posse_jogador
    	fim_loop:	
	bgt s0,s1,vitoria_brasil
	blt s0,s1,vitoria_franca
	j empate
	vitoria_brasil:
		call limpar_tela
		print("\nO Hexa finalmente se encontra nas nossas mãos\n")
		li a0,2
		call sleep
		j fim
	vitoria_franca:
		call limpar_tela
		print("\nO Hexa finalmente se encontra nas nossas mãos\n")
		li a0,2
		call sleep
		j fim
	empate:
		call limpar_tela
		print("\nDepois De um jogo épico, Mbappé e Neymar destroem o planeta em uma dividida e o jogo acaba!\n")
		li a0, 2
		call sleep
		j fim
	fim:
	li a7,10
	ecall 
.include "funcoes.s"
.include "funcoes_jogadores.s"
.include "funcoes_jogadores_franca.asm"

