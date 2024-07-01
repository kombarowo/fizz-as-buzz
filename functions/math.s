.section .data

.include "linux.s"

.section .bss

.section .text

# FUNCTION: pow
#
#    Calculate base**power
#
# PARAMETERS
#
#    %rdi - base
#    %rsi - power
#
.globl pow
.type pow, @function
pow:
    movq $1, %rax

pow_loop_start:
    cmpq $0, %rsi
    je pow_loop_end

    imulq %rdi, %rax

    decq %rsi
    jmp pow_loop_start

pow_loop_end:
    ret
