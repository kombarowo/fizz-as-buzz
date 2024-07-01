.section .data

.include "ascii.s"

.equ VAR_POWER, -8
.equ VAR_BASE, -16

.section .bss
    .lcomm NUM_BUFFER, 4

.section .text

# FUNCTION: str2int
#
#    Convert string to 4-bit integer
#
# PARAMETERS
#
#    %rdi - string address
#
.globl str2int
.type str2int, @function
str2int:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    call strlen
    decq %rax
    movq %rax, VAR_POWER(%rbp)

    movq $0, VAR_BASE(%rbp)
    movq $0, %rax

str2int_loop_start:
    cmpb $0, (%rdi, %rax, 1)
    je str2int_loop_end

    cmpb $ZERO_CHAR, (%rdi, %rax, 1)
    jl str2int_loop_end

    cmpb $NINE_CHAR, (%rdi, %rax, 1)
    jg str2int_loop_end

    pushq %rax

    movzbq (%rdi, %rax, 1), %rcx
    subq $ZERO_CHAR, %rcx

    pushq %rdi
    movq $10, %rdi
    movq VAR_POWER(%rbp), %rsi
    call pow
    popq %rdi

    imulq %rcx, %rax
    addq %rax, VAR_BASE(%rbp)

    popq %rax

str2int_loop_continue:
    incq %rax
    decq VAR_POWER(%rbp)
    jmp str2int_loop_start

str2int_loop_end:
    movq VAR_BASE(%rbp), %rax
    movq %rbp, %rsp
    popq %rbp
    ret

# FUNCTION: int2str
#
#    Convert 4-bit integer to string
#
# PARAMETERS
#
#    %rdi - 4-bit integer
#
.globl int2str
.type int2str, @function
int2str:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    movq $0, %rsi
    movq $10, %rbx
    movq %rdi, %rax

int2str_loop_start:
    movq $0, %rdx
    divq %rbx

    addq $ZERO_CHAR, %rdx
    pushq %rdx

    cmpq $0, %rax
    je int2str_loop_end

    incq %rsi
    jmp int2str_loop_start

int2str_loop_end:
    movq $0, %rax
    movq $NUM_BUFFER, %rdi

int2str_loop_pop:
    popq %r10
    movq %r10, (%rdi, %rax, 1)

    cmpq $0, %rsi
    je int2str_loop_exit

    decq %rsi
    incq %rax
    jmp int2str_loop_pop

int2str_loop_exit:
    movq $NUM_BUFFER, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
