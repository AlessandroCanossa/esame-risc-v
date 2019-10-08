.include "loadMatrix.s"
.include "transpose.s"
.include "multiplication.s"
.global _start

.section .rodata

    matrixA: .byte 0 ,10,0 ,12
             .byte 0 ,0 ,0 ,0
             .byte 0 ,0 ,5 ,0
             .byte 15,12,0 ,0

    matrixB: .byte 0 ,0 ,8 ,0
             .byte 0 ,0 ,0 ,23
             .byte 0 ,0 ,9 ,0
             .byte 20,25,0 ,0

    elemA: .byte 5         # numero di elementi != 0 in A
    elemB: .byte 5         # numero di elementi != 0 in B
    
    nColA: .byte 4         # numero colonne A
    nRowA: .byte 4         # numero righe A
    
    nColB: .byte 4         # numero colonne B
    nRowB: .byte 4         # numero righe B
    
.section .data
    # creiamo gli array relativi alla colonna, riga e valore
    # di dimensione pari a tre volte il numero di elementi diversi da zero 
    # [da inserire a tempo di scrittura]

    sparseA: .space 15        

    sparseB: .space 15
    
    # creiamo l'array relativo alla matrice finale con spazio nRowA * nColB
    # [da inserire a tempo di scrittura]

    matrixC: .space 16

.section .text

_start:
    
    
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
    lb      a2, nColB
    lb      a3, nRowB

    jal     ra, transpose   # calcolo la trasposta di matrixB

    la      a1, sparseB

    lb      a5, elemB       # carico il numero di elementi diversi nella matrice B
    
    jal     ra, loadMatrix  # jump to loadMatrix and save position to ra

    # eseguiamo ora una moltiplicazione tra le due matrici sparse
    # e otteniamo la matrice completa C

    la      a2, sparseA

    la      a0, matrixC

    lb      a3, nRowA       # numero di righe e colonne 
    lb      a4, nColB       # della matrice C 

    lb      a5, elemA       # indica il numero di elementi diversi nella matrice A
    lb      a6, elemB       # indica il numero di elementi diversi nella matrice B 

    jal     ra, multiplication

    li      a7, 93
    ecall  
