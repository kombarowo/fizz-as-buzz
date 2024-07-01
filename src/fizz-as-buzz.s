.section .data

.include "linux.s"

# Command line arguments
.equ ST_ARGC, 0
.equ ST_ARGV_1, 16

# Correct count of command line arguments
.equ ARGC, 2

error_argc:
    .string "Error: expected number of arguments: 1"
fizz:
    .string "Fizz"
buzz:
    .string "Buzz"
fizzbuzz:
    .string "FizzBuzz"

.section .bss

.section .text

.globl _start
_start:
    movq %rsp, %rbp                 # Save stack pointer

argc_check:
    movq ST_ARGC(%rbp), %rax        # Check count of command line arguments
    cmpq $ARGC, %rax
    jne exit_error_argc

conver_first_argv_to_number:
    movq ST_ARGV_1(%rbp), %rdi      # Convert argv1 to number
    call str2int
    movq %rax, %rdi

    movq $1, %rax                   # Init the current number
fizzbuzz_loop_start:
    cmpq %rdi, %rax                 # Compare number and current number
    jg fizzbuzz_loop_end            # End loop if current number > full number

    pushq %rdi                      # Save full number
    pushq %rax                      # Save current number

    movq $15, %rbx                  # Check division by 15
    movq $0, %rdx
    divq %rbx
    cmpq $0, %rdx
    je fizzbuzz_print_fizzbuzz
    popq %rax                       # Re-save current number after division
    pushq %rax

    movq $3, %rbx                   # Check division by 3
    movq $0, %rdx
    divq %rbx
    cmpq $0, %rdx
    je fizzbuzz_print_fizz
    popq %rax                       # Re-save current number after division
    pushq %rax

    movq $5, %rbx                   # Check division by 5
    movq $0, %rdx
    divq %rbx
    cmpq $0, %rdx
    je fizzbuzz_print_buzz
    popq %rax                       # Re-save current number after division
    pushq %rax

    jmp fizzbuzz_print_num

fizzbuzz_print_fizz:
    movq $fizz, %rsi                # Print Fizz
    call print
    call print_newline
    jmp fizzbuzz_loop_continue

fizzbuzz_print_buzz:
    movq $buzz, %rsi                # Print Buzz
    call print
    call print_newline
    jmp fizzbuzz_loop_continue

fizzbuzz_print_fizzbuzz:
    movq $fizzbuzz, %rsi            # Print FizzBuzz
    call print
    call print_newline
    jmp fizzbuzz_loop_continue

fizzbuzz_print_num:
    movq %rax, %rdi                 # Convert number to string
    call int2str
    movq %rax, %rsi                 # Print number
    call print_int
    call print_newline

fizzbuzz_loop_continue:
    popq %rax                       # Get current number after int2str
    popq %rdi                       # Get full number after int2str
    incq %rax                       # Increase current number
    jmp fizzbuzz_loop_start

fizzbuzz_loop_end:
    movq $SYS_EXIT, %rax
    movq $EXIT_SUCCESS, %rdi
    syscall

exit_error_argc:
    movq $error_argc, %rdi
    call print_error
    call print_newline

    movq $SYS_EXIT, %rax
    movq $EXIT_FAILURE, %rdi
    syscall
