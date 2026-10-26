#   def part1_step1(num1: int, num2: int) -> int:
#       result: int = 0
#       i: int = 0
#       while i < num2:
#           result += num1
#           i += 1
#       return result

.text

main:
    addi a1, zero, 6 #num1 = 6
    addi a2, zero, 7 #num2 = 7
    j multiply

multiply: bge t0, a2, ohi #define loop
    #result = a0
    #i = t0
    add a0, a0, a1 #result += num1
    addi t0, t0, 1 #i++
    j multiply #looppaa

ohi:
    li a7, 10 # exit opcode
    ecall # interrupt
