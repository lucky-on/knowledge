def fibonachi(target):
    fib1 = 1
    fib2 = 1

    i = 3
    while i < target + 1:
        tmp = fib2
        fib2 = fib1 + fib2
        fib1 = tmp
        i = i + 1

    return fib2

if __name__ == "__main__":
    print(fibonachi(50))
