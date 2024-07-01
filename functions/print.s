.section .data

.include "linux.s"

newline:
    .ascii "\n"

.section .bss

.section .text

# FUNCTION: print
#
#    Print string to stdout
#
# PARAMETERS
#
#    %rsi - string address
#
.globl print
.type print, @function
print:
        movq %rsi, %rdi
        call strlen
        movq %rax, %rdx

        movq $STDOUT, %rdi
        movq $SYS_WRITE, %rax
        syscall
        ret

# FUNCTION: print_error
#
#    Print error to stderr
#
# PARAMETERS
#
#    %rdi - error
#
.globl print_error
.type print_error, @function
print_error:
        movq %rsi, %rdi
        call strlen
        movq %rax, %rdx

        movq $STDERR, %rdi
        movq $SYS_WRITE, %rax
        syscall
        ret

# FUNCTION: print_newline
#
#    Print newline to stdout
#
.globl print_newline
.type print_newline, @function
print_newline:
        movq $SYS_WRITE, %rax
        movq $STDOUT, %rdi
        movq $newline, %rsi
        movq $1, %rdx
        syscall
        ret

# FUNCTION: print_int
#
#    Print 4-bit integer to stdout
#
.globl print_int
.type print_int, @function
print_int:
        movq $SYS_WRITE, %rax
        movq $STDOUT, %rdi
        movq $4, %rdx
        syscall
        ret
