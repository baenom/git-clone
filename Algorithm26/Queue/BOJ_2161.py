from collections import deque

queue = deque()

N = int(input())

for i in range(1,N+1):
    queue.append(i)
while len(queue) > 1:
    card = queue.popleft()
    queue.append(queue[0])
    queue.popleft()
    print(card, end=' ')
print(queue[0])