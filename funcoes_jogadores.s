#========================================================================================
# Implementação das funções que tratam da lógica de passe e chute para cada zona do campo
#========================================================================================
.text
	.globl funcao_goleiro funcao_zaga funcao_meio_campo funcao_atacante
funcao_goleiro:
	push(ra)
	mv t0,a0
	beqz t0,private_passe_goleiro
	bnez t0,private_chute_goleiro
	private_passe_goleiro:
		li t1,1
		beq s4,t1,private_passe_goleiro_goleiro
		li t1,6
		blt s4,t1,private_passe_goleiro_zaga
		li t1,9
		blt s4,t1,private_passe_goleiro_meio_campo
		j private_passe_goleiro_atacante
		private_passe_goleiro_goleiro:
			j fim_funcao_goleiro
		private_passe_goleiro_zaga:
			li a2,3
			li a3,4
			call calculadora_de_probailidade
			j step_private_passe_goleiro
		private_passe_goleiro_meio_campo:
			li a2,1
			li a3,2
			call calculadora_de_probabilidade
			j step_private_passe_goleiro
		private_passe_goleiro_atacante:
			li a2,1
			li a3,10
			call calculadora_de_probabilidade
		step_private_passe_goleiro:
			call resultado_passe
			j fim_funcao_goleiro
	private_chute_goleiro:
		li a2,1
		li a3,500
		call calculadora_de_probabilidade
		call resultado_chute
	fim_funcao_goleiro:
		pop(ra)
		ret

funcao_zaga:
	push(ra)
	mv t0,a0
	beqz t0,private_passe_zaga
	bnez t0,private_chute_zaga
	private_passe_zaga:
		li t1,1
		beq s4,t1,private_passe_zaga_goleiro
		li t1,6
		blt s4,t1,private_passe_zaga_zaga
		li t1,9
		blt s4,t1,private_passe_zaga_meio_campo
		j private_passe_zaga_atacante
		private_passe_zaga_goleiro:
			li a2,3
			li a3,4
			call calculadora_de_probabilidade
			j step_private_passe_zaga
		private_passa_zaga_zaga:
			j fim_funcao_zaga
		private_passe_zaga_meio_campo:
			li a2,3
			li a3,4
			call calculadora_de_probailidade
			j step_private_passe_zaga
		private_passe_zaga_atacante:
			li a2,1
			li a3,2
			call calculadora_de_probabilidade
		step_passe_zaga:
		call resultado_passe
		j fim_funcao_zaga
	private_chute_zaga:
		li a2,1
		li a3,100
		call calculadora_de_probabilidade
		call resultado_chute
	fim_funcao_zaga:
	pop(ra)
	ret
funcao_meio_campo:	
	push(ra)		
	mv t0,a0
	beqz t0,private_passe_meio_campo
	bnez t0,private_chute_meio_campo
	private_passe_meio_campo:
		li t1,1
		beq s4,t1,private_passe_meio_campo_goleiro
		li t1,6
		blt s4,t1,private_passe_meio_campo_zaga
		li t1,9
		blt s4,t1,private_passe_meio_campo_meio_campo
		j private_passe_meio_campo_atacante
		private_passe_meio_campo_goleiro:
			li a2,1
			li a3,2
			call calculadora_de_probailidade
			j step_private_passe_meio_campo
		private_passe_meio_campo_zaga:
			li a2,3
			li a3,4
			call calculadora_de_probabilidade
			j step_private_passe_meio_campo
		private_passe_meio_campo_meio_campo:
			j fim_funcao_meio_campo
		private_passe_meio_campo_atacante:
			li a2,3
			li a3,4
			call calculadora_de_probabilidade
		step_private_passe_meio_campo:
		call resultado_passe
		j fim_funcao_meio_campo
	private_chute_meio_campo:
		li a2,1
		li a3,3
		call caculadora_probabilidade
		call resultado_chute
	fim_funcao_meio_campo:
		pop(ra)
		ret
funcao_atacante:
	push(ra)
	mv t0,a0
	beqz t0,private_passe_atacante
	bnez t0,private_chute_atacante
	private_passe_atacante:
		li t1,1
		beq s4,t1,private_passe_atacante_goleiro
		li t1,6
		blt s4,t1,private_passe_atacante_zaga
		li t1,9
		blt s4,t1,private_passe_atacante_meio_campo
		j private_passe_atacante_atacante
		private_passe_atacante_goleiro:
			li a2,1
			li a3,10
			call calculadora_de_probabilidade
			j step_private_passe_atacante
		private_passe_atacante_zaga:
			li a2,1
			li a3,2
			call calculadora_de_probabilidade
			j step_private_passe_atacante
		private_passe_atacante_meio_campo:
			li a2,3
			li a3,4
			call calculadora_de_probabilidade
			j step_private_passe_atacante
		private_passe_atacante_atacante:
			j fim_funcao_atacante
		step_private_passe_atacante:
			call resultado_passe
			j fim_funcao_atacante
	private_chute_atacante:
		li a2,1
		li a3,2
		call calculadora_de_probabilidade
		call resultado_chute
	fim_funcao_atacante:
		pop(ra)
		ret
	
			
		
	
	
	
		