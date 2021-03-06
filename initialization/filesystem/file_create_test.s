.section .data

filename:
    .ascii "file_test.txt\0"
message:
    .ascii "test successful!\0"

.section .text

# system calls
.equ SYS_WRITE, 1
.equ SYS_OPEN, 2
.equ SYS_CLOSE, 3
.equ SYS_EXIT, 60


.equ WRITE_ONLY_TRUNC, 03101

.global _start

_start:
    # open file
    mov $filename, %rdi                 # address of filename
    mov $O_CREAT_WRONLY_TRUNC, %rsi
    mov $0666, %rdx                     # perms
    mov $SYS_OPEN, %rax
    syscall
    push %rax                           # push file descriptor onto stack

    # write to file
begin_write_to_file:
    mov (%rsp), %rdi                    # file descriptor
    mov $message, %rsi                  # address of message to print
    mov $0, %rdx

count_characters_loop:
    cmp $0, (%rsi,%rdx,1)
    je end_write_to_file
    inc %rdx
    jmp count_characters_loop

end_write_to_file:
    mov $SYS_WRITE, %rax
    syscall

    # close file
    pop %rdi                            # file descriptor of file to close
    mov $SYS_CLOSE, %rax
    syscall

    mov $SYS_EXIT, %rax
    mov $0, %rbx
    syscall
