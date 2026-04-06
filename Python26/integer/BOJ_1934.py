def getLCM(M,N):
    if M > N: M,N = N,M

    i = 1
    while True:
        multiple = N * i
        if multiple % M == 0:
            return multiple
        i += 1
T = int(input())
for _ in range(T):
    A, B = map(int,input().split())
    print(getLCM(A,B))