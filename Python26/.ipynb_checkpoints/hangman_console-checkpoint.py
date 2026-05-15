from hangman import Hangman 
print()
print('==============hangman ============')
word_list = ['apple','banana','man','woman','tomato']


hangman = Hangman(word_list)
print(hangman.display_word, f"{len(hangman.word)}")
while True:
    hangman.num_try += 1
    letter = input('>> 알파벳 입력 : ')
    resurt = hangman.check_letter(letter)
    if resurt == Hangman.RIGHT:
        print(f"정답 : {hangman.display_word}")
    elif resurt == Hangman.WRONG:
        
        print(f"오답 : {hangman.num_try}의 시도")
    else:
        pass

    resurt = hangman.is_win()
    if resurt == Hangman.WIN:
        print(f"you win !!! : {hangman.num_try}의 시도")
        break
    elif resurt == Hangman.LOSE:
        print(f"you lose !!! : {hangman.word}")
        break
    else:
        pass