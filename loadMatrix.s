.global loadMatrix

.section .text
loadMatrix:
    li      t0, 1      # i = contatore righe 
    li      t1, 1      # j = contatore colonne 
    li      t2, 1      # contatore ciclo for da 1 a righe x colonne

    mul     t5, a2, a3  # numero totale elementi  righe x colonne

    loop:
        lb      t3, 0(a0)           # carichiamo l'elemento  matrix[i][j]

        beq     t3, zero, ifzero    # if matrix[i][j] == 0

        sb      t3, 0(a1)           # salvo il valore in a1 nel primo indice puntato

        add     a1, a1, a5          # mi sposto di a5 posizioni
        sb      t0, 0(a1)           # salvo il numero di riga in a1

        add     a1, a1, a5          # aggiungo altre a5 posizioni
        sb      t1, 0(a1)           # salvo il valore di colonna

        sub     a1, a1, a5
        sub     a1, a1, a5          # rimetto il puntatore all'indice iniziale
        
        addi    a1, a1, 1          # spostiamo di una posizione l'indice dell'array

        ifzero:
            addi    a0, a0, 1          # scorro il puntatore al prossimo elemento della matrice
            addi    t2, t2, 1           # contatore ciclo ++

            blt    t1, a2, nextCol      # se il contatore di colonna è uguale 
                                        # al numero massimo di colonne il contatore di colonne si resetta
                                        # e aumento il contatore riga

            li s8, 0# nuova riga                       
            li      t1, 1               # j = 1
            addi    t0, t0, 1           # i = i + 1

            blt     t2, t5, loop        # se il contatore è minore del numero di elementi della matrice
                                        # rifai il ciclo
            beq     zero, zero, exit
            

            nextCol:
                addi    t1, t1, 1           # j = j + 1 
                ble     t2, t5, loop 
                beq     zero, zero, exit

    exit:
        ret

