.global multiplication

.section .text
multiplication:
    li      t0, 1       # i = 1

    OuterLoop:
        li      t1, 1       # j = 1
        
        lb      t2, 10(a2)       # t2 = valore della colonna di sparseA a riga I
        InnerLoop:
            
            lb      t3, 10(a1)       # t3 = colonna di sparseB a riga J

            bne     t2, t3, target  # if t2 != t3 then target
            
            lb      t4, 5(a2)       # t4 = valore della riga I di sparseA
            lb      t3, 5(a1)       # t3 = valore della riga J di sparseB
            
            # calcolo l'indice della matrice C nel quale posizionare il numero calcolato
            # utilizzo la seguente formula:  I * nrowC - ncolC + J
            index_calculation:
                mul     t4, t4, a3      # parz = I * nrowC
                sub     t4, t4, a4      # parz2 = parz - ncolC
                add     t4, t4, t3      # finale = parz2 + J
                addi    t4, t4, -1

            add     a0, a0, t4      # sposto il puntatore della matrice C all'indice desiderato

            lb      t5, 0(a0)       # carico l'eventuale numero presente nella locazione

            lb      t6, 0(a1)
            lb      t4, 0(a2)
            mul     t6, t6, t4

            add     t5, t5, t6      # sommo il numero con quello calcolato

            sb      t5, 0(a0)       # salvo la somma nella locazione della matrice
            
            la      a0, matrixC     # reinizializzo il puntatore della matrice C

            target: 
                addi    t1, t1, 1   # j++ nuova iterazione
                addi    a1, a1, 1   # passiamo alla riga successiva di sparseB

                ble     t1, a6, InnerLoop   # se t1 è minore del numero di elementi di sparseB
                                            # esegui un nuovo ciclo di InnerLoop
        
        la      a1, sparseB     # resettiamo il puntatore di sparseB

        addi    t0, t0, 1
        addi    a2, a2, 1       # passiamo alla successiva riga di sparseA

        ble     t0, a5, OuterLoop

    la      a0, matrixC
    ret
