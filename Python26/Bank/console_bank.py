class Account:
    def __init__(self,account_no,owner,blance):
        self.__account_no = account_no
        self.__owner = owner
        self.__blance = blance
    def __str__(self):
        return f"{self.__account_no}\t{self.__owner}\t{self.__blance}"
    def deposit(self,amount):
        self.__blance += amount
    def withdrow(self,amount):
        self.__blance += amount
    def get_account_no(self):
        return self.__account_no
    def get_owner(self):
        return self.__owner
    def get_blance(self):
        return self.__blance
class AccountService:
    def __init__(self):
        self.__account_list = []
    def create_account(self, account_no, owner, balance):
        account = Account(account_no, owner, balance)
        self.__account_list.append(account)
    def get_list_account(self):
        return self.__account_list
    def deposit(self,account_no,amount):
        for account in self.__account_list:
            if account.get_account_no() == account_no:
                account.deposit(amount)
                break
    def withdrow(self,account_no,amount):
        for account in self.__account_list:
            if account.get_account_no() == account_no:
                account.withdrow(amount)
                break
        


def select_manu():
    print("===============================================")
    print('1.계좌생성 | 2.계좌목록 | 3.입금 | 4.출금 | 0.종료')
    print("===============================================")
    menu = int(input('>> 메뉴선택 : '))
    return menu

aservice = AccountService()
print()
print('=================Euijin Bank==================')
while True:
    menu = select_manu()
    if menu == 0: break
    elif menu == 1:
        account_no = input("> 계좌번호 : ")
        owner = input("> 계좌주 : ")
        balance = int(input("> 초기 입금액 : "))
        if aservice.create_account(account_no,owner,balance):
            print('계좌가 생성되었습니다')
    elif menu == 2:
        list_account = aservice.get_list_account()
        print('=============')
        print('===계좌목록===')
        print('=============')
        for account in list_account:
            print(account)
    elif menu == 3:
        print('=============')
        print('=====예금====')
        print('=============')
        account_no = input('> 계좌번호')
        amount = int(input('> 예금액 : '))
        aservice.deposit(account_no, amount)
        print(f"{amount}원이 입금되었습니다")
    elif menu == 4:
        print('=============')
        print('=====출금====')
        print('=============')
        account_no = input('> 계좌번호')
        amount = int(input('> 출금액 : '))
        aservice.deposit(account_no, amount)
        print(f"{amount}원이 출금되었습니다")

print('=============이용해주셔서 감사합니다============')