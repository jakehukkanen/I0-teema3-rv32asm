.text

multiply:
  #jos jompikumpi on 0, skippaa
  beqz a1, ohi
  beqz a2, ohi

  #jos a1 tai a2 < 0, negatee a1 tai t2 ja lisää t1:een 1 (t1 on nyt negative sign counter)
  #olkoon t2 1 (eli mitä tarvitaan että muutetaan a0 negatiiviseksi)
  addi t2, zero, 1

  blt a1, zero, num1_negative_sign #if num1 < 0
  num2_check:
      blt a2, zero, num2_negative_sign #if num2 < 0

  j multiply_loop

#toimii täysin samalla lailla kuin askel 1, looppi ei mieti negatiivisia lukuja
multiply_loop: bge t0, a2, ohi #define loop
    #result = a0
    #i = t0
    add a0, a0, a1 #result += num1
    addi t0, t0, 1 #i++
    j multiply_loop #looppaa

num1_negative_sign:
    addi t1, t1, 1 # t1++
    neg a1, a1 #a1 = -a1
    j num2_check # takas sinne mistä ohjelman pitäs jatkua

num2_negative_sign:
    addi t1, t1, 1
    neg a2, a2
    j multiply_loop #num2 on viimenen tarkistus mikä tehdään, voidaan hypätä suoraan looppiin

one_negative_sign: #jos negatiivisia lukuja oli vain yksi, a0 = -a0
    sub a0, zero, a0
    ret

ohi:
    beq t1, t2, one_negative_sign #looppi ohi, tehdään tuo tarkistus
    ret

main:
    addi a1, zero, -6 #num1 = -6
    addi a2, zero, 7 #num2 = 7
    jal ra, multiply #kutsutaan aliohjelma niin että ohje ret vie seuraavalle riville

    li a7, 10 # exit opcode
    ecall # interrupt
