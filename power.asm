# Program will computer the value of 2^3 + 5^2.
# Everything atore in registers so .data section will be empty.

.section	.data

.section	.text
.globl		_start

_start:
	pushl	$3
	pushl	$2
	call	power
	addl	$8, %esp		# Move the stack pointer back.
	
	pushl	%eax			# Save first answer to eax before calling next function.
	
	pushl	$2
	pushl	$5
	call	power
	addl	$8, %esp		# Move the stack pointer back.
	
	popl	%ebx			# Pushed first answer to the stack, second answer already in eax. Pop first into ebx.
	
	addl	%eax, %ebx		# Add results together, result in ebx.
	
	movl	$1, %eax		# Exit & ebx is returned.
	int		$0x80
	
.type power, @function

power:
	pushl	%ebp			# Save old base pointer.
	movl	%esp, %ebp		# Make the stack pointer the base pointer.
	subl	$4, %esp		# Make room for local storage.
	
	movl	8(%ebp), %ebx	# First argument in %eax.
	movl	12(%ebp), %ecx	# Second argument in %ecx.
	
	movl	%ebx, -4(%ebp)	# Store current result.
	
power_loop_start:
	cmpl	$1, %ecx		# If power is 1, end.
	je		end_power
	movl	-4(%ebp), %eax	# Move current result to eax.
	imul	%ebx, %eax		# Multiply current result by base number.
	
	movl	%eax, -4(%ebp)	# Store current result.
	
	decl	%ecx			# Decrement power counter.
	jmp		power_loop_start
	
end_power:					# Basics of terminating.
	movl	-4(%ebp), %eax	# Return value goes in %eax.
	movl	%ebp, %esp		# Restore the stack pointer.
	popl	%ebp			# Restore base pointer.
	ret
	
	
	
	

	
	


