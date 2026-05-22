#=======================================================================
#                 DEFINIÇÃO DOS MACROS
#=======================================================================

.macro print(%str)
.data
    msg: .asciz %str

.text
    li a7, 4
    la a0, msg
    ecall
.end_macro

.macro push(%reg)
    addi sp,sp,-4
    sw %reg,0(sp)
.end_macro

.macro pop(%reg)
    lw %reg,0(sp)
    addi sp,sp,4
.end_macro
