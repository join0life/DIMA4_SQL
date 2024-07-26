/* 7월 26일 : 사용자 생성과 권한 */

-- --------- 사용자
-- 1. 사용자 생성
-- 새로운 사용자를 생성하면서 비밀번호를 설정
CREATE USER 'ogong'@'host' identified BY 'ogong';
CREATE USER 'newuser'@'localhost' identified BY 'newuser';

-- 2. 사용자 삭제
DROP USER 'ogong'@'host';
DROP USER 'newuser'@'localhost';

-- 3. 사용자 권한 부여
GRANT SELECT, INSERT ON dima4.customers TO 'newuser'@'localhost';

-- 모든 권한을 한꺼번에 부여
GRANT ALL PRIVILEGES ON dima4.* TO 'newuser'@'localhost';

-- 4. 권한 적용
flush PRIVILEGES; -- 낮은 버전에서 사용하던 명령.

-- 5. 권한 확인
SHOW GRANTS FOR 'newuser'@'localhost';
SHOW GRANTS FOR 'ogong'@'host';

-- 6. 권한 회수
REVOKE SELECT, INSERT ON dima4.customers FROM 'newuser'@'localhost';

-- 7. 사용자 삭제
DROP USER 'newuser'@'localhost';

-- 지금 현재 사용자 확인
SELECT user();

-- 생성된 모든 사용자 정보를 조회
SELECT USER, host FROM mysql.USER;
DESC mysql.USER;

-- 자신의 이름이나 아이디를 만들어 비밀번호를 만든 후
-- dima4 데이터베이스에 관한 모든 권한을 부여
-- console 창에서 접속되는지 확인하시오
> mysql -u 아이디 -p (엔터)

-- 1. 사용자 생성
-- 새로운 사용자를 생성하면서 비밀번호를 설정
CREATE USER 'hoppang'@'localhost' identified BY 'hoppang';
-- 3. 사용자 권한 부여
GRANT ALL PRIVILEGES ON dima4.* TO 'hoppang'@'localhost';
-- 4. 권한 적용
flush PRIVILEGES; -- 낮은 버전에서 사용하던 명령.
-- 5. 권한 확인
SHOW GRANTS FOR 'hoppang'@'localhost';
-- 6. 사용자 삭제
DROP USER 'hoppang'@'localhost';

-- --------------- 실습 : 테이블 설계하기
/*
 * 아이돌 관련 정보를 저장할 DB를 설계하시오
 * 
 * 조건) 'idol'이라는 이름의 데이터베이스를 생성한 후 작업을 하시오
 * 
 * 
 */
USE dima4;
SHOW database();
/* 수정하기!
CREATE TABLE ent
(
	ent_name varchar(50) NOT NULL
	, CONSTRAINT ent_name_pk PRIMARY KEY (ent_name)
);

CREATE TABLE fandom
(
	fandom_name varchar(50) NOT NULL
	, fandom_num int DEFAULT 0
	, CONSTRAINT fandom_name_pk PRIMARY KEY (fandom_name)
);

CREATE TABLE group
(
	group_name varchar(50) NOT NULL
	, group_num int DEFAULT 0 
	, fandom_name varchar(50) NOT NULL
	, ent_name varchar(50) NOT NULL
	, CONSTRAINT group_name_pk PRIMARY KEY (group_name)
		, CONSTRAINT ent_name_fk FOREIGN KEY (ent_name) REFERENCES ent (ent_name)
		, CONSTRAINT fandom_name_fk FOREIGN KEY (fandom_name) REFERENCES fandom (fandom_name)	
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE info
(
	info_name varchar(50) NOT NULL
	, gender char(1) CHECK (gender IN ('M','F'))
	, age decimal(3) DEFAULT 0
	, height decimal(3) DEFAULT 0
	, group_name varchar(50) NOT NULL
	, fandom_name varchar(50) NOT NULL
	, CONSTRAINT group_name_fk FOREIGN KEY (group_name) REFERENCES `group` (group_name)
	ON DELETE CASCADE ON UPDATE CASCADE
);
*/