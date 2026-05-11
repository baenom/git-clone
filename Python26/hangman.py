import random
class Hangman:
    MASK_CHAR = '_'
    RIGHT = 1
    WRONG = 0
    EXIT = -1
    WIN = 1
    LOSE = 0
    CUNTINU = -1
    MAX_TRY = 7
    def __init__(self,word_list):
        self.word = random.choice(word_list).upper()
        self.display_word = Hangman.MASK_CHAR * len(self.word)
        self.num_try = 0

    def check_letter(self,letter):
        letter = letter.upper()
        if self.word.count(letter) > 0:
            for i in range(len(self.word)):
                if self.word[i] == letter:
                    self.display_word = self.display_word[:i] + letter +self.display_word[i+1:]
            return Hangman.RIGHT
        else:
            return Hangman.WRONG
    def is_win(self):
        if self.display_word.count(Hangman.MASK_CHAR) == 0:
            return Hangman.WIN
        elif self.num_try == Hangman.MAX_TRY:
            return Hangman.LOSE
        pass