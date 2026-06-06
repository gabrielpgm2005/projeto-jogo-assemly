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
    		#Troca a posse para o brasil
    		li s2,0 
    		
    		#Mostra os resultados por 3 segundos e limpa a tela
    		call mostrar_resultado
    		li a0 3
    		call sleep
    		call limpar_tela
    		
    		#Adiciona um minuto ao contador de minutos e se for maior que 90 termina o loop
    		addi s3,s3,1 
    		li t0,90
    		bgt s3,t0,fim_loop 
    		
    		#Mostra as opções para o player
    		call mostrar_opcoes  
    		
    		#Lê qual opção o player escolheu e retorna em a0 o resultado dela
    		#0 em caso de passe completo,1 em caso de gol e 2 em caso de passe incompleto/chute falho
    		call acao_player 
    		
    		# volta ao loop do jogador caso seja um passe completo (a0 = 0)
    		beqz a0,posse_jogador
    		
    		#Troca o jogador que está com a bola para um aleatório
    		mv t2,a0 
    		li a0,11
    		call sortear_numero
    		mv t3,a0 
    		
    		#Verifica se foi gol
    		li t0,1
    		beq t2,t0,posse_jogador_gol 
    		
    		#Verifica se foi chute falho/passe incompleto
    		li t0,2
    		beq t2,t0,posse_maquina 
    		
    		#Atualiza o placar e passa a posse para a máquina
    		posse_jogador_gol:
    			addi s0,s0,1
    			j posse_maquina
    	
    	posse_maquina:
    		#troca de posse para a frança
    		li s2,1 
    		
    		#Mostra o placar por 3 segundos e limpa a tela
    		call mostrar_resultado
    		print("FRANCA COM A BOLA")
    		li a0 3
    		call sleep
    		call limpar_tela
    		
    		#Adiciona 1 ao tempo e caso seja maior que 90 minutos encerra o loop
    		addi s3,s3,1
    		li t0,90
    		bgt s3,t0,fim_loop
    		
    		#Chama a função que trata de qual ação a máquina vai tomar e retorna o resultado dessa ação
    		#Os possveis retornos são os mesmos usados para o brasil
    		call rodada_franca
    		
    		#Volta ao loop para frança indicando passe completo
    		beqz a0,posse_maquina
    		
    		#Troca o jogador que tem a bola para um jogador aleatório
    		mv t2,a0 
    		li a0,11
    		call sortear_numero
    		mv t3,a0 
    		
    		#Verifica se foi gol
    		li t0,1
    		beq t2,t0,posse_maquina_gol
    		
    		#Verifica se foi passe incompleto/chute falho e retorna para a posse do player
    		li t0,2
    		beq t2,t0,posse_jogador
    		
    		#atualiza o placar
    		posse_maquina_gol:
    			addi s1,s1,1
    			j posse_jogador
    	fim_loop:	
    	
    	#Checa se algum venceu 
	bgt s0,s1,vitoria_brasil
	blt s0,s1,vitoria_franca
	#O penalti começa no jogador numero 11
	li t3,11 
	
	#Redefinindo os gols dos times para contar os resultados dos penaltis
	li s0, 0 
	li s1,0
	
	#t5 representa o numero de rodadas de penalti batidas, para verificar se ainda esta nos 5 primeiros
	li t5,0 
	
	loop_penalti:
	
		#Mostra o resultado atual dos penaltis por 2 segundos e limpa a tela 
		call mostrar_resultado_penalti
		li a0,2
		call sleep
		
		penalti_brasil:
		
			#Muda posse para o brasil
			li s2,0 
			
			#Pausa o jogo por 2 segundos
			li a0,2
			call sleep
			
			#Mostra uma mensagem com o nome do jogador que vai bater
			mv a0,t3 
			call mostrar_posicao_atual
			print(" Com a bola!\n")
			
			#define a probabilidade de acerto do penalti
			li a2,1
			li a3,2
			call calculadora_de_probabilidade
			
			#Mostra o resultado do chute e pula para a vez da franca se errou
			call resultado_chute
			li t0,1
			bne t0,a0,penalti_franca
			addi s0,s0,1
			
		penalti_franca:
			#Muda a posse para a frança
			li s2,1
			
			#Pausa o jogo por 2 segundos
			li a0,2
			call sleep
			
			#Mostra uma mensagem com o nome do jogador com a bola 
			mv a0,t3
			call mostrar_posicao_atual
			print(" Com a bola!\n")
			
			#Define a probabilidade de acerto do penalti
			li a2,1
			li a3,2
			call calculadora_de_probabilidade
			call resultado_chute
			
			#verifica o resultado, se acertou incrementa 1,=
			li t0,1
			bne t0,a0,step_penalti
			addi s1,s1,1
			
		step_penalti:
		
			#Aumenta o contador de rodadas de penalti
			addi t5,t5,1
			
			#Atualiza os jogadores que vão chutar
			#formula = atual%11 + 1
			li t1,11
			rem t0,t3,t1
			li t1,1
			add t3,t0,t1
			
			# Se menos de 5 rodadas de penaltis foram batidas, retorna ao loop
			li t0,5
			blt t5,t0,loop_penalti
			
			# Verifica quem venceu, se continua empatado chama o loop mais uma vez
			bgt s0,s1,vitoria_brasil
			bgt s1,s0,vitoria_franca
			j loop_penalti
			
		
				
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
	fim:
	li a7,10
	ecall 
.include "funcoes.s"
.include "funcoes_jogadores.s"
.include "funcoes_jogadores_franca.asm"

