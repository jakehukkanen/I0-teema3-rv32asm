#   def part1_step5():
#       num1 = int(input("Enter num1: "))
#       num2 = int(input("Enter num2: "))
#
#       num1_positive = (num1 >= 0)
#       num2_positive = (num2 >= 0)
#
#       result: int = 0
#       i: int = 0
#
#       while i < abs(num2):
#           result += abs(num1)
#           i += 1
#
#       both_negative = not num1_positive and not num2_positive
#       result_negative = (not num1_positive and not both_negative) or (not num2_positive and not both_negative)
#       if result_negative:
#           result = -result;
#       print(result)



.data
    res: .space 12

    msg: .string "Enter num1: \n"
    msg2: .string "Enter num2: \n"
    msg3: .string "The result is: "
.text

multiply:
  mv t0, zero #t0 = 0, koska sitä käytetään myöhemmin i:nä, ja t0 ei välttämättä ole 0
  mv a0, zero #a0 = 0, koska sekin pitää näköjään alustaa
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
    # print enter num1
    la a0, msg
    li a7, 4
    ecall

    # read int
    li a7, 5
    ecall

    mv a1, a0

    # print enter num2
    la a0, msg2
    li a7, 4
    ecall

    # read int
    li a7, 5
    ecall

    mv a2, a0

    # print the result is:
    # printataan tää ensin ettei tarvii tehä ylimääräisiä mv:eitä
    la a0, msg3
    li a7, 4
    ecall

    jal ra, multiply #kutsutaan aliohjelma niin että ohje ret vie seuraavalle riville

    # print result
    li a7, 1
    ecall

    la t1, res #res:n osoite t1
    sw a0, 0(t1) #talletetaan tulos muistiin

    li a7, 10 # exit
    ecall
