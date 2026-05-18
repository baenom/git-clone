import member_manager as MemberService

member_service = MemberService()

while True:
    print()
    print("1. 회원가입 | 2. 회원 목록 | 3. 회원 상세 정보 | 4. 회원 정보 수정 | 5. 회원 탈퇴 | 6. 종료")
    choice = input("원하는 작업을 선택하세요: ")
    
    if choice == '1':
        user_id = input("아이디: ")
        password = input("비밀번호: ")
        name = input("이름: ")
        phone = input("전화번호: ")
        address = input("주소: ")
        if not user_id.strip() or not password.strip():
            print("아이디와 비밀번호는 필수 입력 항목입니다.")
            continue
        member_service.join(user_id, password, name, phone, address)

    elif choice == '2':
        if not member_service.members:
            print("등록된 회원이 없습니다.")
        else:
            member_service.get_all_members()

    elif choice == '3':
        try:
            member_number = int(input("회원 번호: "))
            member_service.get_member_deta(member_number)
        except ValueError:
            print("회원 번호는 숫자만 입력 가능합니다.")

    elif choice == '4':
        user_id = input("회원 아이디: ")
        member_password = input("비밀번호: ")
        for i in member_service.members:
            if i.user_id == user_id and i.password == member_password:
                new_name = input("새 이름: ")
                new_phone = input("새 전화번호: ")
                new_password = input("새 비밀번호: ")
                new_address = input("새 주소: ")
                member_service.update_member(i.member_number, new_name, new_phone, new_password, new_address)
                break
        else:
            print("회원 정보가 일치하지 않습니다.")

    elif choice == '5':
        user_id = input("회원 아이디: ")
        member_password = input("비밀번호: ")
        for i in member_service.members:
            if i.user_id == user_id and i.password == member_password:
                member_service.delete_member(i.member_number)
                break
        else:
            print("존재하지 않는 회원입니다.")

    elif choice == '6':
        print("프로그램을 종료합니다.")
        break

    else:
        print("잘못된 선택입니다. 다시 시도하세요.")