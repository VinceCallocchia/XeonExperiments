# Writes characters to the screen and exits without the support from a library.

.section .data

basic_test:
    .ascii "Test Successful!\n"
basic_test_end:

.equ basic_test_len, basic_test_end - basic_test

.equ STDOUT, 1
.equ WRITE, 1
.equ EXIT, 60

.section .text

.global _start

_start:
    mov $WRITE, %rax
    mov $STDOUT, %rdi
    mov $basic_test, %rsi
    mov $basic_test_len, %rdx
    syscall

    mov $EXIT, %rax
    mov $0, %rdi
    syscall
    