def part1_step1(num1: int, num2: int) -> int:
    result: int = 0
    i: int = 0
    while i < num2:
        result += num1
        i += 1
    return result

print(str(part1_step1(6, 7)))
