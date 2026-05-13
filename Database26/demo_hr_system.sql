/* 시스템 계정으로 접속 CONN system ......*/
/* 실습의 편의를 위해 ORACLE 12C 이상의 CDB 환경에서 사용, 사용자 이름 c## 추가 */
/* hr 계정 생성 - 추가실습용 */

DROP USER c##hr CASCADE; 	-- 이미 존재하는 c##hr 계정을 삭제한다.
CREATE USER c##hr IDENTIFIED BY hr  -- c##hr 계정을 생성한다.
DEFAULT TABLESPACE users 
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

GRANT CONNECT, RESOURCE TO c##hr; -- c##hr 에게 권한을 부여한다.
ALTER USER c##hr ACCOUNT UNLOCK; -- c##hr 계정을 사용할 수 있도록 한다.
COMMIT;