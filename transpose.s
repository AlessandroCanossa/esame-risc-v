.global transpose

.section .data
    matrixApp: .space 16

.section .text
transpose:
    # riceviamo come parametro una matrice
    # mettiamo la sua trasposta in matrixApp
    # ritorniamo l'indirizzo di matrixApp in a0

    la      a1, matrixApp

    mv      s1, t2      # offset

    li      t0, 0      # i = contatore righe 

    outerloop:
        
        li      t1, 0               # j = contatore colonne

        innerloop:
             
            lb      t3, 0(a0)           # carichiamo l'elemento  matrix[i][j]

            sb      t3, 0(a1)           # inseriamo l'elemento matrix[i][j] nella posizione matrixApp[j][i]

            addi    t1, t1, 1           # aumento contatore colonne

            add     a1, a1, s1          # sposta il puntatore di a1 di 4 indirizzi

            addi    a0, a0, 1           # sposta il puntatore di a0 di 1 indirizzo

            blt     t1, t4, innerloop   # se il contatore colonna è minore del numero delle colonne
                                        # esegui una nuova iterazione dell'innerloop
            
        addi    t0, t0, 1           # aumento contatore righe

        la      a1, matrixApp       # reinizializzo il puntatore di matrixApp

        add     a1, a1, t0          # sposto il puntatore di matrixApp di un numero di caselle pari a t0
        
        blt     t0, t2, outerloop   # se il contatore righe è minore o uguale al numero delle righe
                                    # esegui una nuova iterazione dell'outerloop
 
    local_exit:
        la      a1, matrixApp
        mv      a0, a1
        ret
