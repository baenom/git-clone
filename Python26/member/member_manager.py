class Member:
    def __init__(self, member_number, user_id, password, name, phone, address):
        self.member_number = member_number
        self.user_id = user_id
        self.password = password
        self.name = name
        self.phone = phone
        self.address = address
    

class MemberService:
    def __init__(self):
        self.members = []
        self.members_num = 1

    def join(self, user_id, password, name, phone, address):
        check = True
        for i in self.members:
            if i.user_id == user_id:
                print("이미 존재하는 아이디입니다.")
                check = False
                break
    
        if check:
            new_member = Member(self.members_num, user_id, password, name, phone, address)
            self.members.append(new_member)
            self.members_num += 1
            print("회원가입이 완료되었습니다.")

    def get_all_members(self):
        print("회원 목록")
        for i in self.members:
            print(f"번호: {i.member_number}, 아이디: {i.user_id}, 이름: {i.name}")

    def get_member_deta(self, member_number):
        for i in self.members:
            if i.member_number == member_number:
                print(f"아이디: {i.user_id}")
                print(f"이름: {i.name}")
                print(f"전화번호: {i.phone}")
                print(f"주소: {i.address}")
                return
        print("해당 회원을 찾을 수 없습니다.")

    def update_member(self, member_number, new_name, new_phone, new_password, new_address):
        for i in self.members:
            if i.member_number == member_number:
                i.name = new_name
                i.phone = new_phone
                i.password = new_password
                i.address = new_address
                print("정보 수정이 완료되었습니다.")
                return
        print("수정할 회원이 없습니다.")

    def delete_member(self, member_number):
        target_index = -1
        for i in range(len(self.members)):
            if self.members[i].member_number == member_number:
                target_index = i
                break
        
        if target_index != -1:
            self.members.pop(target_index)
            print("탈퇴 처리가 완료되었습니다.")
        else:
            print("삭제할 회원을 찾지 못했습니다.")

