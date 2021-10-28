# Demonstation on calling "printf".

.section .data

firststring:
    .ascii "Hello! %s is %s printf function %d times\n\0"
name:
    .ascii "This\0"
secondstring:
    .ascii "testing the\0"
number:
    .long 2

.equ EXIT, 60

.section .text

.globl _start
    
_start:
    mov $firststring, %rdi
    mov $name, %rsi
    mov $secondstring, %rdx
    mov number, %rcx
    call  printf
    
    mov $0, %rdi
    call  exit
