.text

.include "macros.s"
main:

    call apresentacao_inicial
    call limpar_tela
    
    li s0,0 # S0 = GolsBrasil
    li s1,0 # s1 = GolsFranca
    loop_jogo:
    	call opcoes_jogador # Lê o input do jogador e o retorna em a0
    	mv t0,a0 # Salva o valor do input do usuario em t0
    	li a0,3 # Define o limite dos numeros sorteados
    	call sortear_numero # Escolhe aleatoriamente para onde a máquina vai e guarda em a0
    	mv a1,t0 
    	call resultado #retorna 0 caso não tenha gol, 1 se houve
    	beqz a0,continua_jogador
    	addi s0,s0,1
    	continua_jogador:
    	print("\nATAQUE DA FRANÇA,ESCOLHA ONDE IRÁ DEFENDER")
    	call opcoes_jogador
    	mv t0,a0
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
