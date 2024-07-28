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
/* 걸그룹 아이돌 데이터 관리 프로그램 */
/*
[문제]
걸그룹과 팬클럽, 그리고 걸그룹 소속사를 관리하는 데이터베이스를 설계하려고 한다.
필요하다고 판단되는 모든 테이블과 컬럼을 ERD로 그리고, 코드 설계하시오.
*/

CREATE DATABASE idol;
USE idol;

DROP TABLE idol.IDOL_FAN_CLUB;        -- 팬클럽
DROP TABLE idol.IDOL_MEMBER;        -- 아이돌 멤버
DROP TABLE idol.IDOL_TEAM;            -- 아이돌
DROP TABLE idol.AGENCY;                -- 소속사

-- 소속사 테이블
CREATE TABLE idol.AGENCY
(
AGENCY_ID INT AUTO_INCREMENT PRIMARY KEY,        -- AGENCY 아이디
AGENCY_NAME VARCHAR(50) UNIQUE,                -- 소속사명
CEO VARCHAR(20) NOT NULL,                 -- 대표명
TEL VARCHAR(20) NOT NULL,                 -- 대표전화 NN
STOCK CHAR(1) DEFAULT 'N' CHECK (STOCK IN ('Y', 'N')),
FOUNDED_YEAR DECIMAL(4) ,                        -- 설립연도
IDOL_TEAM_COUNT DECIMAL(3) DEFAULT 1            -- 관리하는 아이돌 팀 수
);


INSERT INTO idol.AGENCY
( AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, IDOL_TEAM_COUNT)
VALUES
( 'KITA ENTERTAINMENT', '삼장법사', '02-111-8888', 2023, 5);

INSERT INTO idol.AGENCY
(AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, STOCK, IDOL_TEAM_COUNT)
VALUES
('(주) SM', '이수만', '02-333-0000', 1990, 'Y', 20);

SELECT * FROM idol.AGENCY;

-- 아이돌 팀 테이블
CREATE TABLE IDOL_TEAM
(
TEAM_ID            INT    AUTO_INCREMENT PRIMARY KEY,                -- PK
TEAM_NAME            VARCHAR(50),                -- 팀명
MEMBER_CNT        INT,                        -- 인원수
LEADER            CHAR(1) DEFAULT 'N' CHECK (LEADER IN('Y', 'N')), -- 팀리더 ('Y', 'N')
DEBUT_DATE        DATE,                        -- 데뷔일
AGENCY_ID            INT REFERENCES AGENCY(AGENCY_ID)    -- FK
);

CREATE TABLE idol.IDOL_MEMBER
(
IDOL_ID INT AUTO_INCREMENT PRIMARY KEY,
IDOL_NAME VARCHAR(50),                        -- 아이돌 활동명
BIRTHDAY DATETIME,                                -- 팀원 생년월일
COUNTRY VARCHAR(30),                        -- 국적
POSITIONS VARCHAR(30),                        -- 역할 (예: 보컬, 랩, 댄스, 비주얼)
GENDER CHAR(1) CHECK (GENDER IN('M', 'F')),    -- 성별 ('M', 'F')
TEAM_ID INT REFERENCES IDOL_TEAM(TEAM_ID)    -- FK
);


-- 팬클럽 정보 테이블
CREATE TABLE idol.IDOL_FAN_CLUB
(
CLUB_NAME VARCHAR(20) PRIMARY KEY,            -- 팬클럽명 PK
PAY INT DEFAULT 50000,                    -- 가입비
COLOR VARCHAR(30),                            -- 팬클럽 색상
FAN_CNT INT DEFAULT 0,                    -- 팬클럽 회원 수
TEAM_ID INT REFERENCES IDOL_TEAM(TEAM_ID)    -- FK
);