import random

word_screen = []
blank_char = '_'

def select_word():
    word_list = ['apple','banana','man','woman','tomato']
    
    return random.choice(word_list)

target_word = select_word()


error_limit = 7

num_error = 0

word_screen = blank_char * len(target_word)

while num_error < error_limit:
    user_input = input(">> 알파벳을 입력하시오:")
    if target_word.find(user_input) == -1:
        num_error += 1
        print("오류횟수:",num_error)
    else:
        for i in range(len(target_word)):
            if target_word[i] == user_input:
                word_screen = word_screen[:i] + user_input + word_screen[i+1:]
    print(word_screen)
    if word_screen.count(blank_char) == 0:
        print("you win!!!")
        break
if num_error >= error_limit:
    print("you loose ....:", target_word)