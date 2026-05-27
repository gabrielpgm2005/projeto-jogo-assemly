#========================================================
#               MAIN FRANCA
#========================================================

.text
.include "macros.s"
.include "funcoes.asm"
.include "funcoes_jogadores_franca.asm"

main:
	call apresentacao_inicial
	call limpar_tela
	
	#inicio
	li s0, 0 #gol BRA
	li s1, 0 #gol FRA
	li s2, 1 # posse (nesse caso come�a com fran�a, main_franca)*************
	li s3, 6 #posicao inicial meio-campo
	
#ignorar o loop_jogo na hora de transferir, ele � espec�fico pra fran�a
loop_jogo:
	bne s2, x0, rodada_franca #se posse FRA, joga(foco nas jogadas da franca)
	print("\n FRANCA PERDEU A POSSE, PROXIMA RODADA \n")
	li s2, 1 #devolve posse pra FRA
	j loop_jogo
	
#pegar rodada_franca
rodada_franca:
	bgt s1, s0, franca_defesa_call
	# empate ou perdendo faz pressao
	call franca_pressao
	j pos_rodada
	
#pegar franca_defesa_call
franca_defesa_call:
	call franca_defesa
	j pos_rodada

pos_rodada:
	call mostrar_resultado
	# condicao de fim
	li t2, 5
	bge s0, t2, fim
	bge s1, t2, fim
	j loop_jogo

fim:
	li a7, 10
	ecall
