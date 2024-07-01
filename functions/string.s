.section .data

.include "linux.s"

.section .bss

.section .text

# FUNCTION: strlen
#
#    Get length of string
#
# PARAMETERS
#
#    %rdi - string address
#
.globl strlen
.type strlen, @function
strlen:
    movq $0, %rax

strlen_loop_start:
    cmpb $0, (%rdi, %rax, 1)
    je strlen_loop_end

    incq %rax
    jmp strlen_loop_start

strlen_loop_end:
    ret
