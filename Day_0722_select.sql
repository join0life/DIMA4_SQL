-- 2024년 7월 22일 (월)

/*

**** SQL (Structured Query Language)
- DBMS에 접근해서 처리하는 명령어들
- 국제 표준이지만, 각 벤더별로 명령문이 조금씩 다르다!
- 명령어의 종류


1) DDL (Database Definition Language) : 객체를 다루는 명령
	create(생성), alter(변경), drop(삭제)
	
2) DML (Database Manipulation Language) : 테이블의 레코드를 다루는 명령
	insert(삽입), select(조회), update(수정), delete(삭제)
	
3) TCL (Transaction Control Language) : 트랜젝션을 다루는 명령
	commit(저장), rollback(전체 되돌림), savepoint(되돌릴 위치까지 되돌림)
	
4) DCL (Database Control Language) : 권한을 다루는 명령
	grant(권한 부여), revoke(권한 회수)

주의)
- SQL 명령은 ;으로 끝나야 한다.

*/


/***** SELECT 문
- 테이블의 내용을 조회
*/

-- SELECT 컬럼명 FROM 테이블명;
USE hr;

SELECT * FROM employees;
SELECT first_name, hire_date, salary
FROM employees e ;

-- 기본 데이터 확인하기
SELECT * FROM countries c ;
SELECT * FROM regions r ;
SELECT * FROM departments d ;
SELECT * FROM employees e ;

-- 이름과 급여 정보를 조회하시오.
SELECT first_name, salary
FROM employees e ;

-- 부서번호를 조회하시오.
SELECT department_id FROM employees e ;




