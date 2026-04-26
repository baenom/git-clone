S = input()
i = int(input())

count = 1
for j in S:
    if count == i:
        print(j)
        break
    count += 1