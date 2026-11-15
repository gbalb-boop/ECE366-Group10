
.data
m: .word 7
result: .word 0

.text
.globl main

main:
    lw $t0, m
    li $t1, 2
# this keeps subtracting 2 until the remaindar is less than 2
loop:
    blt $t0, $t1, done
    sub $t0, $t0, $t1
    j loop

done:
    beq $t0, $zero, even

    li $t2, 1
    j store

even:
    li $t2, 0
# save 1 if odd and then 0 if even
store:
    sw $t2, result

    li $v0, 10
    syscall

