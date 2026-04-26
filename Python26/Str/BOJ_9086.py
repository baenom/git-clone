num = int(input())

for _ in range(num):
    S = input()
    S_list = []
    for i in S:
        S_list.append(i)
    print(f'{S_list[0]}{S_list[-1]}')
    S_list.clear()
