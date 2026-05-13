/* 시스템 계정으로 접속 CONN system ......*/
/* 실습의 편의를 위해 ORACLE 12C 이상의 CDB 환경에서 사용, 사용자 이름 c## 추가 */

DROP USER c##madang CASCADE; 	-- 이미 존재하는 c##madang 계정을 삭제한다.
CREATE USER c##madang IDENTIFIED BY madang  -- c##madang 계정을 생성한다.
	DEFAULT TABLESPACE users 
	TEMPORARY TABLESPACE temp
	QUOTA UNLIMITED ON users;

GRANT CONNECT, RESOURCE TO c##madang; -- c##madang 에게 권한을 부여한다.
ALTER USER c##madang ACCOUNT UNLOCK; -- c##madang 계정을 사용할 수 있도록 한다.
COMMIT;