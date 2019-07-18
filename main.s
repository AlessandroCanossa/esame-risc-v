.global _start

.section .rodata
    matrixA: .byte 0,0,0,0,
                   0,0,0,0,
                   0,0,1,0

    matrixB: .byte 0,0,0,0,
                   0,0,0,0,
                   0,0,0,0

    nElem: .byte 4          #numero colonne

.section .data
    rowA: .space 1
    colA: .space 1



.section .text
_start:
    la a0, rowA
    la a1, colA

    li a0, 9


    li a3, 93
    ecall   
    