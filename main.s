#.include "print.s"
.include "loadMatrix.s"
.include "transpose.s"
.include "multiplication.s"

.equ _SYS_WR, 64

.global _start


.section .rodata

    matrixA: .byte 5 ,0,0 ,2
             .byte 0 ,7 ,0 ,0
             .byte 0 ,0 ,0 ,3

    matrixB: .byte 0 ,0 ,4
             .byte 0 ,2 ,0
             .byte 0 ,0 ,7
             .byte 10,0 ,0

    elemA: .byte 4         # numero di elementi != 0 in A
    elemB: .byte 4         # numero di elementi != 0 in B
    
    nColA: .byte 4         # numero colonne A
    nRowA: .byte 3         # numero righe A
    
    nColB: .byte 3         # numero colonne B
    nRowB: .byte 4         # numero righe B
    
.section .data
    # creiamo gli array relativi alla colonna, riga e valore
    # di dimensione pari a tre volte il numero di elementi diversi da zero 
    # [da inserire a tempo di scrittura]

    sparseA: .space 12        

    sparseB: .space 12
    
    # creiamo l'array relativo alla matrice finale con spazio nRowA * nColB
    # [da inserire a tempo di scrittura]

    matrixC: .space 9

.section .text
_start:
#main:
    
    # carico la matrice A
    la      a0, matrixA

    # carico il numero di elementi di righe e colonne
    lb      a2, nColA
    lb      a3, nRowA

    la      a1, sparseA

    lb      a5, elemA       # carico il numero di elementi diversi nella matrice A

    jal     ra, loadMatrix  # jump to loadMatrix and save position to ra
    
    # carico la matrice B
    la      a0, matrixB

    # carico il numero di elementi di righe e colonne
    lb      a2, nRowB
    lb      a3, nColB

    jal     ra, transpose   # calcolo la trasposta di matrixB

    la      a1, sparseB

    lb      a5, elemB       # carico il numero di elementi diversi nella matrice B
    
    jal     ra, loadMatrix  # jump to loadMatrix and save position to ra

    # eseguiamo ora una moltiplicazione tra le due matrici sparse
    # e otteniamo la matrice completa C

    la      a2, sparseA
    la      a1, sparseB

    #li s10, 15
    #la s2, sparseA
    #jal ra, print

    la      a0, matrixC

    lb      a3, nRowA       # numero di righe e colonne 
    lb      a4, nColB       # della matrice C 

    lb      a5, elemA       # indica il numero di elementi diversi nella matrice A
    lb      a6, elemB       # indica il numero di elementi diversi nella matrice B 

    jal     ra, multiplication

    #la s2, matrixC
    #li s10, 16
    #jal ra, print
    
    li      a7, 93
    ecall  
