#========================================================================================
# Implementa��o das fun��es que trabalham a l�gica de jogada da fran�a
#========================================================================================

.text	
# ============================== rodada franca 
rodada_franca:
	push(ra)
	bgt s1, s0, franca_defesa
	# empate ou perdendo faz pressao
	j franca_pressao
	pop(ra)
	ret
#=========================================================== franca pressao
franca_pressao:
    push(ra)
    li t1, 1
    beq t3, t1, private_pressao_goleiro
    li t1, 6
    blt t3, t1, private_pressao_zaga
    li t1, 9
    blt t3, t1, private_pressao_meio_campo
    j private_pressao_atacante

    private_pressao_goleiro:
        li a2, 1
        li a3, 200
        call calculadora_de_probabilidade
        bnez a0, private_pressao_goleiro_chute
        li a2, 8
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_pressao_goleiro_meio
        j private_pressao_goleiro_ataque
        private_pressao_goleiro_chute:
            li a0, 1
            call funcao_goleiro
            j fim_franca_pressao
        private_pressao_goleiro_meio:
            li a0, 3
            call sortear_numero
            addi t4, a0, 5
            j step_private_pressao_goleiro
        private_pressao_goleiro_ataque:
            li a0, 3
            call sortear_numero
            addi t4, a0, 8
        step_private_pressao_goleiro:
            li a0, 0
            call funcao_goleiro
            j fim_franca_pressao

    private_pressao_zaga:
        li a2, 1
        li a3, 100
        call calculadora_de_probabilidade
        bnez a0, private_pressao_zaga_chute
        li a2, 7
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_pressao_zaga_meio
        j private_pressao_zaga_ataque
        private_pressao_zaga_chute:
            li a0, 1
            call funcao_zaga
            j fim_franca_pressao
        private_pressao_zaga_meio:
            li a0, 3
            call sortear_numero
            addi t4, a0, 5
            j step_private_pressao_zaga
        private_pressao_zaga_ataque:
            li a0, 3
            call sortear_numero
            addi t4, a0, 8
        step_private_pressao_zaga:
            li a0, 0
            call funcao_zaga
            j fim_franca_pressao

    private_pressao_meio_campo:
        li a2, 1
        li a3, 20
        call calculadora_de_probabilidade
        bnez a0, private_pressao_meio_campo_chute
        li a2, 8
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_pressao_meio_campo_ataque
        j private_pressao_meio_campo_zaga
        private_pressao_meio_campo_chute:
            li a0, 1
            call funcao_meio_campo
            j fim_franca_pressao
        private_pressao_meio_campo_ataque:
            li a0, 3
            call sortear_numero
            addi t4, a0, 8
            j step_private_pressao_meio_campo
        private_pressao_meio_campo_zaga:
            li a0, 4
            call sortear_numero
            addi t4, a0, 1
        step_private_pressao_meio_campo:
            li a0, 0
            call funcao_meio_campo
            j fim_franca_pressao

    private_pressao_atacante:
        li a2, 7
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_pressao_atacante_chute
        li a0, 3
        call sortear_numero
        addi t4, a0, 8
        j step_private_pressao_atacante
        private_pressao_atacante_chute:
            li a0, 1
            call funcao_atacante
            j fim_franca_pressao
        step_private_pressao_atacante:
            li a0, 0
            call funcao_atacante
            j fim_franca_pressao

fim_franca_pressao:
    pop(ra)
    ret
#=========================================================== franca pressao


#=========================================================== franca defesa
franca_defesa:
    push(ra)
    li t1, 1
    beq t3, t1, private_defesa_goleiro
    li t1, 6
    blt t3, t1, private_defesa_zaga
    li t1, 9
    blt t3, t1, private_defesa_meio_campo
    j private_defesa_atacante

    private_defesa_goleiro:
        li a2, 1
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_defesa_goleiro_meio
        j private_defesa_goleiro_zaga
        private_defesa_goleiro_meio:
            li a0, 3
            call sortear_numero
            addi t4, a0, 5
            j step_private_defesa_goleiro
        private_defesa_goleiro_zaga:
            li a0, 4
            call sortear_numero
            addi t4, a0, 1
        step_private_defesa_goleiro:
            li a0, 0
            call funcao_goleiro
            j fim_franca_defesa

    private_defesa_zaga:
        li a2, 1
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_defesa_zaga_meio
        j private_defesa_zaga_tras
        private_defesa_zaga_meio:
            li a0, 3
            call sortear_numero
            addi t4, a0, 5
            j step_private_defesa_zaga
        private_defesa_zaga_tras:
            li a0, 4
            call sortear_numero
            addi t4, a0, 1
        step_private_defesa_zaga:
            li a0, 0
            call funcao_zaga
            j fim_franca_defesa

    private_defesa_meio_campo:
        li a2, 1
        li a3, 10
        call calculadora_de_probabilidade
        bnez a0, private_defesa_meio_campo_ataque
        j private_defesa_meio_campo_zaga
        private_defesa_meio_campo_ataque:
            li a0, 3
            call sortear_numero
            addi t4, a0, 8
            j step_private_defesa_meio_campo
        private_defesa_meio_campo_zaga:
            li a0, 4
            call sortear_numero
            addi t4, a0, 1
        step_private_defesa_meio_campo:
            li a0, 0
            call funcao_meio_campo
            j fim_franca_defesa

    private_defesa_atacante:
        li a2, 1
        li a3, 20
        call calculadora_de_probabilidade
        bnez a0, private_defesa_atacante_ataque
        j private_defesa_atacante_meio
        private_defesa_atacante_ataque:
            li a0, 3
            call sortear_numero
            addi t4, a0, 8
            j step_private_defesa_atacante
        private_defesa_atacante_meio:
            li a0, 3
            call sortear_numero
            addi t4, a0, 5
        step_private_defesa_atacante:
            li a0, 0
            call funcao_atacante
            j fim_franca_defesa

fim_franca_defesa:
    pop(ra)
    ret
#=========================================================== franca defesa
