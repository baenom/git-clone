while True:
    N, M = map(int, input().split(' '))

    if M % N == 0:
        print('factor')
    elif N % M == 0:
        print('multiple')
    else:
        print('neither')
    
    if M == 0 and N == 0:
        break