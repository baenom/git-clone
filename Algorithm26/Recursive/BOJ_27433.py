N = int(input())

def fac(num):
    if num <= 1: return 1
    return num * fac(num-1)

print(fac(N))