# Writes characters to the screen and exits with the support from a library.

.section .data

basic_test:
    .ascii "Test Successful\n\0"

.section .text

.globl _start
    
_start:
    movq $basic_test, %rdi
    call  printf

    movq $0, %rdi
    call  exit

