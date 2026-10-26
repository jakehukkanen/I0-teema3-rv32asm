.data
    num1: .word -6
    num2: .word 7

    res: .space 12
.text

multiply:
  mv t0, zero #t0 = 0, koska sitä käytetään myöhemmin i:nä, ja t0 ei välttämättä ole 0
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
    la t0, num1 #kopioidaan num1 osoite t0:aan
    lw a1, 0(t0) #sitten kopioidaan t0:ssa sijaitsevan sanan arvo a1
    la t0, num2 #toistetaan num2:lle
    lw a2, 0(t0) #ja a2:lle

    jal ra, multiply #kutsutaan aliohjelma niin että ohje ret vie seuraavalle riville

    la t1, res #res:n osoite t1
    sw a0, 0(t1) #talletetaan tulos muistiin

    li a7, 10 # exit opcode
    ecall # interrupt
