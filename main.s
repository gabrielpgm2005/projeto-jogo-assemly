.data 

# Brasil
nome_br_1:  .string "Alisson"
nome_br_2:  .string "Alex Sandro"
nome_br_3:  .string "Leo Pereira"
nome_br_4:  .string "Marquinhos"
nome_br_5:  .string "Danilo"
nome_br_6:  .string "Casemiro"
nome_br_7:  .string "Paqueta"
nome_br_8:  .string "Bruno Guimaraes"
nome_br_9:  .string "Endrick"
nome_br_10: .string "Neymar"
nome_br_11: .string "Rayan"

tabela_brasil:
    .word nome_br_1
    .word nome_br_2
    .word nome_br_3
    .word nome_br_4
    .word nome_br_5
    .word nome_br_6
    .word nome_br_7
    .word nome_br_8
    .word nome_br_9
    .word nome_br_10
    .word nome_br_11

# França
nome_fr_1:  .string "Maignan"
nome_fr_2:  .string "Kounde"
nome_fr_3:  .string "Saliba"
nome_fr_4:  .string "Upamecano"
nome_fr_5:  .string "Theo Hernandez"
nome_fr_6:  .string "Tchouameni"
nome_fr_7:  .string "Cherki"
nome_fr_8:  .string "Griezmann"
nome_fr_9:  .string "Dembele"
nome_fr_10: .string "Mbappe"
nome_fr_11: .string "Olise"

tabela_franca:
    .word nome_fr_1
    .word nome_fr_2
    .word nome_fr_3
    .word nome_fr_4
    .word nome_fr_5
    .word nome_fr_6
    .word nome_fr_7
    .word nome_fr_8
    .word nome_fr_9
    .word nome_fr_10
    .word nome_fr_11

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
    		li s2,0
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
    		beqz a0,posse_jogador
    		mv t2,a0 # Salva o status de saida de posse do jogador em t2
    		li a0,11
    		call sortear_numero
    		mv t3,a0
    		li t0,1
    		beq t2,t0,posse_jogador_gol
    		li t0,2
    		beq t2,t0,posse_maquina
    		posse_jogador_gol:
    			addi s0,s0,1
    			j posse_maquina
    	
    	posse_maquina:
    		li s2,1
    		call mostrar_resultado
    		print("FRANCA COM A POSSE DA BOLA")
    		li a0 3
    		call sleep
    		call limpar_tela
    		addi s3,s3,1
    		li t0,90
    		bgt s3,t0,fim_loop
    		call rodada_franca
    		beqz a0,posse_maquina
    		mv t2,a0 # Salva o status de saida de posse_maquina em t2
    		li a0,11
    		call sortear_numero
    		mv t3,a0
    		li t0,1
    		beq t2,t0,posse_maquina_gol
    		li t0,2
    		beq t2,t0,posse_jogador
    		posse_maquina_gol:
    			addi s1,s1,1
    			j posse_jogador
    	fim_loop:	
	bgt s0,s1,vitoria_brasil
	blt s0,s1,vitoria_franca
	j empate
	vitoria_brasil:
		call limpar_tela
		print("\nO Hexa finalmente se encontra nas nossas maos, o Brasil vai a loucura!!!! \n")
		li a0,2
		call sleep
		j fim
	vitoria_franca:
		call limpar_tela
		print("\nO Perdemos mais uma vez o Hexa... Talvez na proxima vez. \n")
		li a0,2
		call sleep
		j fim
	empate:
		call limpar_tela
		print("\nDepois De um jogo epico, Mbappe e Neymar destroem o planeta em uma dividida e o jogo acaba!\n")
		li a0, 2
		call sleep
		j fim
	fim:
	li a7,10
	ecall 
.include "funcoes.s"
.include "funcoes_jogadores.s"
.include "funcoes_jogadores_franca.asm"

