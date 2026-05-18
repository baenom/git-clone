from hangman import Hangman
print()
print('==============hangman ============')

# word_list = ['apple','banana','man','woman','tomato']

filename = 'hangman/voca.txt'

def random_choice(filename):
    word_list = []
    with open(filename, encoding='utf-8') as f_read:
        for i in f_read:
            words = i.split()
            if words:
                word_list.append(words[0])
    return word_list

hangman = Hangman(random_choice(filename))

print(hangman.display_word, f"{len(hangman.word)}")
while True:
    letter = input('>> 알파벳 입력 : ')
    # if not letter.isalpha():
    #     print('알파벳을 입력하세요')
    #     continue

    resurt = hangman.check_letter(letter)
    if resurt == Hangman.RIGHT:
        print(f"정답 : {hangman.display_word}")
    elif resurt == Hangman.WRONG:
        
        print(f"오답 : {hangman.num_try}의 시도")
    else:
        print(hangman.error_status)
        continue

    resurt = hangman.is_win()
    if resurt == Hangman.WIN:
        print(f"you win !!! : {hangman.num_try}의 시도")
        break
    elif resurt == Hangman.LOSE:
        print(f"you lose !!! : {hangman.word}")
        break
    else:
        pass