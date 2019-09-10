.include "loadMatrix.s"
.include "transpose.s"
.include "multiplication.s"
.global _start

.section .data

    matrixA: .byte 0,10,0,12,0,0,0,0,0,0,5,0,15,12,0,0

    matrixB: .byte 0,0,8,0,0,0,0,23,0,0,9,0,20,25,0,0

    nColA: .byte 4         # numero colonne A
    nRowA: .byte 4         # numero righe A
    
    nColB: .byte 4         # numero colonne B
    nRowB: .byte 4         # numero righe B
    
    # creiamo gli array relativi alla colonna, riga e valore
    # di dimensione pari al numero di elementi diversi da zero
    # [da inserire a tempo di scrittura]

    sparseA: .space 15        

    sparseB: .space 15

    matrixC: .space 16

.section .text

_start:
    # carico gli indirizzi degli array relativi alla matrice A
    la      a0, matrixA

    # carico il numero di elementi di righe e colonne
    lb      t2, nColA
    lb      t4, nRowA

    la      a1, sparseA

    jal     ra, loadMatrix  # jump to loadMatrix and save position to ra
    
    # carico gli indirizzi degli array relativi alla matrice B
    la      a0, matrixB

    # carico il numero di elementi di righe e colonne
    lb      t2, nColB
    lb      t4, nRowB

    jal     ra, transpose   # calcolo la trasposta di matrixB

    la      a1, sparseB
    
    jal     ra, loadMatrix  # jump to loadMatrix and save position to ra

    # eseguiamo ora una moltiplicazione tra le due matrici sparse
    # e otteniamo la matrice completa C

    la      a2, sparseA

    la      a0, matrixC

    lb      a3, nRowA   # numero di righe e colonne 
    lb      a4, nColB   # della matrice C 

    li      a5, 5        # indica il numero di elementi diversi nella matrice A
    li      a6, 5       # indica il numero di elementi diversi nella matrice B [da inserire a mano]

    jal     ra, multiplication

    li      a7, 93
    ecall   
    
