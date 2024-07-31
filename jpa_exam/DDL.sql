-- 데이터베이스 생성
DROP DATABASE jpatest;
CREATE DATABASE jpatest CHARACTER SET utf8mb4;

-- 사용자 계정 생성 (jpauser)
DROP USER 'jpauser'@'localhost';
CREATE USER 'jpauser'@'localhost' identified BY 'jpauser';

DROP USER 'jpauser'@'%';
CREATE USER 'jpauser'@'%' identified BY 'jpauser';

-- 권한 부여
GRANT ALL PRIVILEGES ON jpatest.* TO 'jpauser'@'localhost';
GRANT ALL PRIVILEGES ON jpatest.* TO 'jpauser'@'%';

-- 샘플 테이블 생성 (Java jpa_exam 프로젝트와 연동하는 테이블의 생성)
DROP TABLE jpatest.cashbook;

CREATE TABLE jpatest.cashbook
(
	seq int AUTO_INCREMENT PRIMARY KEY
	, today datetime DEFAULT current_timestamp
	, item_type varchar(20)
	, detail varchar(200) NOT NULL
	, amount int 
	, note varchar(500)
);
SELECT * FROM jpatest.cashbook;