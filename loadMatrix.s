
.global loadMatrix

.section .text
loadMatrix:
    li      t0, 1      # i = contatore righe 
    li      t1, 1      # j = contatore colonne 
    li      t6, 1      # contatore ciclo for da 1 a righe x colonne
    li      s1, 1      # offset

    mul     t5, t2, t4  # numero totale elementi  righe x colonne

    loop:
        lb      t3, 0(a0)    # carichiamo l'elemento  matrix[i][j]

        beq     t3, zero, ifzero   # if matrix[i][j] == 0

        sb      t3, 0(a1)
        sb      t0, 5(a1)
        sb      t1, 10(a1) 
        
        add     a1, a1, s1

        ifzero:
            add     a0, a0, s1      # scorro il puntatore al prossimo elemento della matrice
            addi    t6, t6, 1       # contatore ciclo ++

            blt    t1, t2, nextCol  # se il contatore di colonna è uguale 
                                    # al numero massimo di colonne il contatore di colonne si resetta
                                    # e aumento il contatore riga

            # nuova riga                       
            li      t1, 1           # j = 1
            addi    t0, t0, 1       # i = i + 1

            blt     t6, t5, loop    # se il contatore è minore del numero di elementi della matrice
                                    # rifai il ciclo
            beq     zero, zero, exit
            

            nextCol:
                addi    t1, t1, 1   # j = j + 1 
                blt     t6, t5, loop 
                beq     zero, zero, exit

    exit:
        ret

