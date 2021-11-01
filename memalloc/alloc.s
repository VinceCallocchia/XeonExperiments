# Program to demonstrate the management of memory usage - allocates and deallocates memory as requested.

.section .data

# This points to the beginning of the memory we are managing.
heap_begin:
    .quad 0

# This points to one location past the memory we are managing.
# Meaning, the heap ends just before this address.
current_break:
    .quad 0

.equ UNAVAILABLE, 0
.equ AVAILABLE, 1
.equ SYS_BRK, 12

.equ HEADER_SIZE, 16
.equ HDR_AVAIL_OFFSET, 0
.equ HDR_SIZE_OFFSET, 8

.section .text

# Call this function to initialize the functions which sets up heap_begin and current_break.
.global allocate_init
.type allocate_init, @function
allocate_init:
    push %rbp
    mov %rsp, %rbp

    mov $SYS_BRK, %rax              # Perform a system call to find out where the break (end of heap) is.
    mov $0, %rbx
    syscall

    inc %rax                        # Address in rax is now one beyond the end of the heap.
    mov %rax, current_break
    mov %rax, heap_begin            # Putting invalid address, allocate function resets the break, so that we actually have memory.

    mov %rbp, %rsp
    pop %rbp
    ret

.global allocate
.type allocate, @function
.equ ST_MEM_SIZE, 16                # Location of size of memory requested on stack when allocate is invoked.
allocate:
    push %rbp
    mov %rsp, %rbp

    mov ST_MEM_SIZE(%rbp), %rcx # rcx holds the size of memory requested
    mov heap_begin, %rax
    mov current_break, %rbx

alloc_loop_begin:
    cmp %rbx, %rax  # compare current_break with heap_begin
    je move_break

    mov HDR_SIZE_OFFSET(%rax), %rdx # grab the size of this memory
    cmp $UNAVAILABLE, HDR_AVAIL_OFFSET(%rax)
    je next_location

    cmp %rdx, %rcx # is there enough space available in this slot of memory?
    jle allocate_here

next_location:
    add $HEADER_SIZE, %rax
    add %rdx, %rax
    jmp alloc_loop_begin

allocate_here:
    movq $UNAVAILABLE, HDR_AVAIL_OFFSET(%rax)
    add $HEADER_SIZE, %rax

    mov %rbp, %rsp
    pop %rbp
    ret

move_break:
    add $HEADER_SIZE, %rbx # rbx = current_break
    add %rcx, %rbx  # request that current_break be at least equal to current_break + header size + size of memory requested

    push %rax
    push %rbx
    push %rcx

    mov $SYS_BRK, %rax
    syscall

    cmp $0, %rax    # check for error conditions
    je error

    pop %rcx
    pop %rbx
    pop %rax

    movq $UNAVAILABLE, HDR_AVAIL_OFFSET(%rax)
    mov %rcx, HDR_SIZE_OFFSET(%rax)
    add $HEADER_SIZE, %rax # move rax to the start of usable memory. rax now holds the return value
    mov %rbx, current_break

    mov %rbp, %rsp
    pop %rbp
    ret

error:
    mov $0, %rax
    mov %rbp, %rsp
    pop %rbp
    ret

.global deallocate
.type deallocate, @function
.equ ST_MEMORY_SEG, 8
deallocate:
    mov ST_MEMORY_SEG(%rsp), %rax
    sub $HEADER_SIZE, %rax
    movq $AVAILABLE, HDR_AVAIL_OFFSET(%rax)
    ret
