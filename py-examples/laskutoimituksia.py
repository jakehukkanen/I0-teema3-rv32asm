def part1_step1(num1: int, num2: int) -> int:
    result: int = 0
    i: int = 0
    while i < num2:
        result += num1
        i += 1
    return result

print(str(part1_step1(6, 7)))

def part1_step2(num1: int, num2: int) -> int:
    num1_positive = (num1 >= 0)
    num2_positive = (num2 >= 0)

    result: int = 0
    i: int = 0
    while i < abs(num2): # can negate the negative sign of the int using neg in risc-v asm, which uses sub under the hood
        result += abs(num1)
        i += 1
    both_negative = not num1_positive and not num2_positive
    result_negative = (not num1_positive and not both_negative) or (not num2_positive and not both_negative) # huh huh
    if result_negative:
        result = -result;
    return result

print(str(part1_step2(6, 7)))
print(str(part1_step2(-6, 7)))
print(str(part1_step2(-6, -7)))
