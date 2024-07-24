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

-- SELECT 컬럼명 FROM 테이블명
-- ORDER BY 컬럼명 DESC;
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

-- 부서번호를 정렬하여 조회하시오.
-- 오름차순(asc), 내림차순(Desc)
SELECT department_id FROM employees e
ORDER BY department_id DESC;

--------- 7월 23일
-- 스키마 생성
CREATE SCHEMA dima4 DEFAULT CHARACTER SET UTF8MB4;

DROP SCHEMA dima4;

-- 스키마 사용
USE hr;
SHOW tables;

USE sakila;

-- 테이블의 내용 조회
SELECT * FROM employees;

SELECT first_name, salary, job_id
FROM employees e
ORDER BY salary DESC;

-- ORDER BY를 이용한 정렬
-- 1차, 2차 등으로 세분화해서 정렬 가능
-- ORDER BY절은 가장 마지막에 와야 함.
-- job_id별로 오름차순, job_id가 같은 경우 이름 알파벳순으로 오름차순
SELECT first_name, salary, job_id
FROM employees e
ORDER BY job_id ASC, first_name ASC, salary DESC ;

-- DISTINCT / ALL
-- 조회한 레코드의 모든 데이터가 같을 경우 중복을 배제
SELECT ALL salary, job_id
FROM employees
ORDER BY job_id ASC;

/*
WHERE 절
조건을 주어서 조건에 부합하는 정보만 조회할 때 사용
모든 레코드를 전부 조사
TRUE나 FALSE로 반환되는 조건을 WHERE에서 사용

산술연산자
+ - * /

비교연산자
= != >= <= > <

논리연산자
AND, OR, NOT

BETWEEN 값 AND 값
AND 연산과 유사

IN 연산자 
OR 연산자와 유사

NULL 비교
IS NULL, IS NOT NULL
'' -> 빈 문자열은 NULL이 아님

LIKE 연산자
문자열 내에 포함된 특별한 문자값을 찾아서 조회할 때
(각 컬럼의 값이 문자열이거나, 날짜일 때 적용할 수 있다.)
특별한 와일드카드와 함께 사용

% : 0개 이상의 글자를 의미
_ : _당 한 개의 글자를 의미\

LIMIT
조회한 결과의 일부만 재추출해서 조회할 때 사용

limit 개수; : 제일 앞에서부터 개수만큼 조회
limit 건너뛸 개수(n1), 조회할 개수(n2) : 맨 앞에서 n1개 건너뛰고 n2개 조회

 */
SELECT first_name, salary, job_id
FROM employees e
WHERE salary >= 10000
ORDER BY salary DESC;

-- 80번 부서에 속한 직원을 모두 조회하시오
SELECT first_name, department_id 
FROM employees e 
WHERE department_id = 80;

-- [연습] 급여가 10000 이상인 직원의 사원번호, 이름, 급여, 직급을 조회하시오
SELECT * FROM employees e ;

SELECT employee_id, first_name, salary, job_id
FROM employees e 
WHERE salary >= 10000;

-- [연습] 급여가 5000 이상 10000 이하인 직원의 사원번호, 이름, 급여, 직급을 조회하시오
-- 급여별로 내림차순!
SELECT employee_id, first_name, salary, job_id
FROM employees e 
WHERE salary >= 5000 AND salary <= 10000
ORDER BY salary DESC ;

-- [연습] BETWEEN 연산자를 이용하여 위의 문제를 수정
SELECT employee_id, first_name, salary, job_id
FROM employees e 
WHERE salary BETWEEN 5000 AND 10000
ORDER BY salary DESC ;

-- [연습] 부서가 10번이거나 50번인 직원의 이름, 직급, 부서번호 조회하시오
SELECT first_name, job_id, department_id 
FROM employees e 
WHERE department_id = 10 OR department_id = 50;

-- [연습] 부서가 10번, 50번이 아닌 직원의 이름, 직급, 부서번호 조회하시오
-- 부서별로 오름차순 
SELECT first_name, job_id, department_id 
FROM employees e 
WHERE NOT (department_id = 10 OR department_id = 50)
ORDER BY 3 DESC ;

-- [연습] 이름, 급여, 커미션 비율을 조회하시오. NULL 값 조회
SELECT first_name, salary, commission_pct 
FROM employees e ;

-- [연습] 이름, 급여, 커미션 비율을 조회하시오. 커미션을 받는 직원만
-- WHERE commission_pct != NULL; -- NULL값은 비교연산자 사용 불가
SELECT first_name, salary, commission_pct 
FROM employees e 
WHERE commission_pct IS NOT NULL;

-- [연습] 이름, 급여, 직급, 커미션 비율을 조회하시오.
-- 커미션을 받는, 직급이 SA_MAN인 직원만 조회
-- 문자열 값을 다룰 땐 ''를 사용, ""는 별칭을 쓸 때
SELECT first_name, salary, job_id, commission_pct 
FROM employees e 
WHERE commission_pct IS NOT NULL
AND job_id = 'SA_MAN';

-- 별칭 붙이기
SELECT first_name AS "이 름", salary AS "월 급", job_id, commission_pct 
FROM employees e 
WHERE commission_pct IS NOT NULL;

-- [연습] 이름, 급여, 커미션 금액, 총수령액을 조회하시오
SELECT first_name 이름, salary 급여, commission_pct * salary "커미션 금액",
	salary + (commission_pct * salary) 총수령액
FROM employees e 
WHERE commission_pct IS NOT NULL;

-- 나머지 연산자 
SELECT 10 % 3
FROM DUAL; -- DUAL : dummy 테이블

-- LIKE 연산자
-- [연습] 이름이 'J'로 시작하는 직원의 이름과 부서를 조회하시오
SELECT FIRST_name, department_id
FROM employees e 
WHERE first_name LIKE 'J%';

-- [연습] 이름이 'n'으로 끝나는 직원의 이름과 부서를 조회하시오
SELECT FIRST_name, department_id
FROM employees e 
WHERE first_name LIKE '%n';

-- [연습] 이름이 'n'으로 끝나며 이름이 5자인 직원의 이름과 부서를 조회하시오
SELECT FIRST_name, department_id
FROM employees e 
WHERE first_name LIKE '____n';

-- [연습] 이름, 입사일, 급여를 조회
SELECT first_name, hire_date, salary
FROM employees e ;

-- [연습] 2007년도에 입사한 직원의 이름, 입사일, 급여를 조회
SELECT first_name, hire_date, salary
FROM employees e
WHERE hire_date LIKE '2007%';

-- [연습] 1월에 입사한 직원의 이름, 입사일, 급여를 조회
SELECT first_name, hire_date, salary
FROM employees e
WHERE hire_date LIKE '_____01%';

-- [연습] 2007년 이전에 입사한 직원의 이름과 입사년도를 조회하시오
-- 입사일 순으로 정렬
SELECT first_name, hire_date 
FROM employees e 
WHERE hire_date <= '2007-01-01'
ORDER BY hire_date ;

-- IN 연산자
-- [연습] 사원번호가 145번이거나 147번, 158번인 사람을 조회
-- 사원번호, 이름, 전화번호
SELECT employee_id, first_name, phone_number 
FROM employees e 
WHERE 
	employee_id IN (145, 147, 158);
	
-- [연습] 부서번호가 80이거나 50인 직원의 명단(이름, 부서번호, 직급)을 조회
SELECT first_name, department_id , job_id 
FROM employees e 
WHERE 
	department_id IN (50, 80);

-- LIMIT
-- 맨 앞에서부터 10개 조회
SELECT employee_id, first_name, salary 
FROM employees e 
LIMIT 10;

-- LIMIT (건너뛸 개수, 조회할 개수)
SELECT employee_id, first_name, salary 
FROM employees e 
LIMIT 5, 10;

/* 변수의 사용(사용자 정의 변수) */
-- 변수 선언과 초기화
-- 자바에서 =은 대입연산자, MySQL에서 =은 같은지 묻는 비교연산자
-- MySQL에서 :=은 대입연산자
SET @low := 4000, @hi := 6000; -- 변수 선언 및 초기화
SELECT @low, @hi;
SELECT @test; -- @ test 변수는 초기화하지 않았기 때문에 Null

-- 변수의 값을 쿼리문에서 사용하기
SELECT * FROM employees e
WHERE salary BETWEEN @low AND @hi;