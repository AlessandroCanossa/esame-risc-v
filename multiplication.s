.global multiplication

.section .text
multiplication:
    li      t0, 1       # i = 1

    OuterLoop:
        li      t1, 1       # j = 1
        
        add     a2, a2, a5      # sposto il puntatore di a2 di a5*2 elementi
        add     a2, a2, a5
        lb      t2, 0(a2)       # t2 = valore della colonna di sparseA a riga I
        sub     a2, a2, a5
        sub     a2, a2, a5      # metto a posto il puntatore

        InnerLoop:
            add     a1, a1, a6
            add     a1, a1, a6
            lb      t3, 0(a1)       # t3 = colonna di sparseB a riga J
            sub     a1, a1, a6
            sub     a1, a1, a6

            bne     t2, t3, next_iteration  # se i valori delle colonne differiscono then next_iteration
            
            add     a1, a1, a6
            add     a2, a2, a5
            lb      t4, 0(a2)       # t4 = valore della riga I di sparseA
            lb      t3, 0(a1)       # t3 = valore della riga J di sparseB
            sub     a1, a1, a6
            sub     a2, a2, a5

            # calcolo l'indice della matrice C nel quale posizionare il numero calcolato
            # utilizzo la seguente formula:  row * nrowC - ncolC + col - 1
            # il meno uno serve per aggiustare gli spostamenti del puntatore
            index_calculation:
                mul     t4, t4, a3      # parz = row * nrowC
                sub     t4, t4, a4      # parz2 = parz - ncolC
                add     t4, t4, t3      # finale = parz2 + col
                addi    t4, t4, -1

            add     a0, a0, t4      # sposto il puntatore della matrice C all'indice desiderato

            lb      t5, 0(a0)       # carico l'eventuale numero presente nella locazione

            lb      t6, 0(a1)       # carico il valore della matrice B all'indice desiderato
            lb      t4, 0(a2)       # eseguo la stessa operazione per la matrice A
            mul     t6, t6, t4      # moltiplico i due valori

            add     t5, t5, t6      # sommo il numero con quello calcolato

            sb      t5, 0(a0)       # salvo la somma nella locazione della matrice
            
            la      a0, matrixC     # reinizializzo il puntatore della matrice C

            next_iteration: 
                addi    t1, t1, 1           # j++ nuova iterazione
                addi    a1, a1, 1           # passiamo alla riga successiva di sparseB

                ble     t1, a6, InnerLoop   # se t1 è minore del numero di elementi di sparseB
                                            # esegui un nuovo ciclo di InnerLoop
        
        la      a1, sparseB     # resettiamo il puntatore di sparseB

        addi    t0, t0, 1       # i++ nuova iterazione
        addi    a2, a2, 1       # passiamo alla successiva riga di sparseA

        ble     t0, a5, OuterLoop

    la      a0, matrixC     # resetto il puntatore della matrice C
    ret
