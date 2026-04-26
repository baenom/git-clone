import sys
from collections import deque

input = sys.stdin.readline

queue = deque()
N = int(input())

for _ in range(N):
    op = input().split()

    if op[0] == 'push':
        queue.append(int(op[1]))

    elif op[0] == 'pop':
        if queue:
            print(queue.popleft())
        else:
            print(-1)
            
    elif op[0] == 'size':
        print(len(queue))
        
    elif op[0] == 'empty':
        print(1 if not queue else 0)
        
    elif op[0] == 'front':
        if queue:
            print(queue[0])
        else:
            print(-1)
            
    elif op[0] == 'back':
        if queue:
            print(queue[-1])
        else:
            print(-1)