/* 7월 24일 수요일 */

-- DML : insert, select, update, delete
/*
 * update 테이블명
 * set first_name = '오공'
 * where employee_id = 199
 * 
 */

-- 1:오토커밋을 활성화, 0: 오토커밋을 비활성화
SET autocommit = 0;

USE hr;
SELECT DATABASE ();

-- 1) insert into select문
-- select 해서 나온 결과를 새로운 테이블을 생성해서 복사하는 방법
SELECT *
FROM hr.employees e ;

INSERT INTO hr.employees 
(employee_id , first_name, last_name, hire_date, job_id)
VALUES
(999, '길동', '홍', '2024-07-24', 'IT_PROG'); -- 복제본에 저장 
 
-- employees를 복사하여 새로운 테이블 emp2 만들기
CREATE TABLE hr.emp2
SELECT * 
FROM hr.employees e ;

SELECT * FROM hr.emp2;

-- 사원번호 100번인 사람의 이름을 '오공'으로 수정
UPDATE hr.emp2
SET first_name = '오공'
WHERE employee_id = 100;

SELECT * FROM hr.emp2;

ROLLBACK; -- 되돌림. 단, auto_commit = FALSE 인 경우

UPDATE hr.emp2
SET first_name = 'Steven';

-- DELETE문 : 레코드를 삭제
/*
 * delete from 테이블명
 * where 조건절;
 */

SELECT *
FROM hr.emp2;

-- 커미션이 없는 직원을 삭제하시오
DELETE FROM hr.emp2
WHERE commission_pct IS NULL;

DROP TABLE hr.emp2;

UPDATE hr.emp2
SET salary = salary * 1.1;

-- SH_CLERK인 직급을 전부 SA_REP로 수정하시오
UPDATE hr.emp2
SET job_id = 'SA_REP'
WHERE job_id = 'SH_CLERK';

-- [문제] 80번 부서의 직원들만 새로운 테이블(emp_80)로 옮기고
CREATE TABLE hr.emp_80
SELECT *
FROM hr.employees
WHERE department_id = 80;

SELECT * 
FROM hr.emp_80 ;

-- [문제] emp_80 테이블의 모든 직원의 급여를 25% 올리시오
UPDATE hr.emp_80
SET salary = salary * 1.25;

-- insert문의 auto_increment의 사용 복습
DROP TABLE dima4.mytbl;
CREATE TABLE dima4.mytbl
(
	userid 			int AUTO_INCREMENT PRIMARY KEY
	, name 			varchar(30) NOT NULL
	, age 			int DEFAULT 0
	, join_date 	datetime DEFAULT current_timestamp
	, today 		date DEFAULT (current_date)
	, `now` 		datetime DEFAULT (current_time)
);

DESC dima4.mytbl;

INSERT INTO dima4.mytbl
(name, age)
VALUES
('이몽룡', 20);

SELECT * FROM dima4.mytbl;

INSERT INTO dima4.mytbl
(userid, name, age)
VALUES
(NULL, '김방자', 22);

SELECT * FROM dima4.mytbl;

SELECT last_insert_id();

-- 날짜 관련 데이터 타입 테스트하기
USE dima4;

CREATE TABLE timetest
(
	col1 date
	, col2 datetime
	, col3 timestamp
	, col4 time
	, col5 year
);

DESC timetest;

INSERT INTO dima4.timetest
VALUES
(
	current_timestamp
	, current_timestamp
	, current_timestamp
	, current_timestamp
	, current_timestamp
);

SELECT * FROM dima4.timetest;

/*
* JOIN 
*	- 두 개의 테이블(관계가 형성되어 있는 테이블)로부터 데이터를 조회
*	- 두 테이블은 PK, FK가 있어야 한다.
* 조인의 종류
* 1) CROSS JOIN (= 카르테시안 조인)
* 	A x B
* 
* 2) INNER JOIN (= JOIN ON)
* 	: 서로 관계를 맺고 있는 둘 이상의 테이블로부터 데이터를 조회
* 	: FK 값이 NULL인 경우에는 조회대상에서 제외된다.
* 
* ※ USING절을 이용한 조인
* 	: ON절을 USING으로 바꿈 
*/

USE hr;
SELECT * FROM hr.employees;
SELECT * FROM hr.departments d ;

-- 1) 카르테시안 조인 (크로스 조인) 
SELECT *
FROM hr.employees e CROSS JOIN hr.departments d ; -- CROSS JOIN 생략 가능

SELECT *
FROM hr.employees e, hr.departments d ; 

-- 2) Inner join : 조건절이 포함되어 PK와 FK가 같은 데이터를 조회
-- 두 테이블의 조인조건을 on절에 기재
-- 조인 컬럼에 NULL을 가진 레코드는 조회 대상에서 제외
SELECT *
FROM hr.employees e INNER JOIN hr.departments d 
ON e.department_id = d.department_id ;

-- [연습] 사원번호, 이름, 급여, 부서명
SELECT e.employee_id, e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
ON e.department_id = d.department_id ;

-- [연습] 위 코드를 USING절로 수정하기
SELECT e.employee_id, e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
USING (department_id) ;

-- 사원번호, 이름, 급여, 부서명
-- 사원번호로 오름차순
SELECT e.employee_id, e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
ON e.department_id = d.department_id
ORDER BY e.employee_id ;

-- 위 코드를 USING절로 수정
SELECT e.employee_id, e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
USING (department_id)
ORDER BY e.employee_id ;

-- [문제] 급여가 5000을 초과하는 직원의 이름, 급여, 부서명을 조회하시오
SELECT e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
ON e.department_id = d.department_id
WHERE e.salary > 5000;

-- [문제] 위 코드를 USING절로 수정
SELECT e.first_name, e.salary, d.department_name 
FROM hr.employees e INNER JOIN hr.departments d 
USING (department_id)
WHERE e.salary > 5000;

-- [문제] 급여가 200을 초과하는 직원의 이름, 급여, 부서명, 근무하는 도시
-- employees(FK-department_id), departments(PK-department_id, FK-location_id), locations(PK-location_id)
SELECT * FROM hr.locations;
SELECT * FROM hr.departments d ;

SELECT e.first_name, e.salary, d.department_name, l.city
FROM 
	hr.employees e INNER JOIN hr.departments d
		ON e.department_id = d.department_id
	INNER JOIN hr.locations l
		ON d.location_id = l.location_id
WHERE e.salary >5000
ORDER BY salary DESC;

-- [문제] 위 코드를 USING절로 수정
SELECT * FROM hr.locations;
SELECT * FROM hr.departments d ;

SELECT e.first_name, e.salary, d.department_name, l.city
FROM 
	hr.employees e INNER JOIN hr.departments d
		USING (department_id)
	INNER JOIN hr.locations l
		USING (location_id)
WHERE e.salary >5000
ORDER BY salary DESC;

-- [연습문제] 부서명과 부서가 속한 도시와 해당 도시가 있는 나라를 조회하시오
-- departments(department_name), locations(location_id, country_id), countries(country_id)
SELECT d.department_name , l.city, c.country_name
FROM 
	hr.departments d INNER JOIN hr.locations l
		ON d.location_id = l.location_id
	INNER JOIN hr.countries c
		ON l.country_id = c.country_id;
		
-- [문제] 위 코드를 USING절로 수정
SELECT d.department_name , l.city, c.country_name
FROM 
	hr.departments d INNER JOIN hr.locations l
		USING (location_id)
	INNER JOIN hr.countries c
		USING (country_id);

/* Outer Join
 * - inner join은 FK가 null이면 조회에서 제외 
 * - outer join은 모든 데이터를 다 조회
 * - Left Outer Join(NULL을 가진 테이블(자식)을 왼쪽에 배치)  / Right Outer Join
 * - Outer는 생략 가능
 * 
 */

-- [문제] 전 직원의 이름, 급여, 부서명을 조회하시오
SELECT e.first_name, e.salary, e.department_id 
FROM hr.employees e 
LEFT OUTER JOIN hr.departments d 
ON e.department_id = d.department_id;

-- 위 코드를 USING절로 수정
SELECT e.first_name, e.salary, e.department_id 
FROM hr.employees e 
LEFT OUTER JOIN hr.departments d 
USING (department_id);
	
-- [문제] 부서명과 부서가 위치한 도시와 해당 도시가 있는 나라를 조회하시오
-- Right outer join으로 할 것! (자식을 오른쪽)
-- departments(department_name), locations(location_id, country_id), countries(country_id)
SELECT d.department_name , l.city, c.country_name
FROM hr.countries c RIGHT OUTER JOIN hr.locations l 
ON c.country_id = l.country_id
RIGHT OUTER JOIN hr.departments d 
ON l.location_id = d.location_id ;

/* self join
 * - 하나의 테이블에 PK와 FK를 같이 가지고 있는 경우
 * - USING절을 쓰기 어려움
 */
-- manager_id : FK
SELECT employee_id, first_name, manager_id 
FROM hr.employees e 

-- [문제] 사원 번호와 이름, 상관의 사원 번호와 상관의 이름을 조회하시오
-- 부모의 PK가 자식의 FK로 전이

SELECT e1.employee_id, e1.first_name AS "직원명", e2.employee_id, e2.first_name AS "Manager명"
FROM hr.employees e1 /* 자식을 왼쪽에 FK */
INNER JOIN hr.employees e2 /* 부모를 오른쪽에 PK */ 
ON e1.manager_id = e2.employee_id ; -- 자식의 FK와 부모의 PK

-- [문제] 위 문제에서 Steven도 출력되도록 하시오 (총 107명이 조회되어야 함)
-- left outer join
SELECT e1.employee_id, e1.first_name AS "직원명", e2.employee_id, e2.first_name AS "Manager명"
FROM hr.employees e1 /* 자식을 왼쪽에 FK */
LEFT JOIN hr.employees e2 /* 부모를 오른쪽에 PK */ 
ON e1.manager_id = e2.employee_id ; -- 자식의 FK와 부모의 PK

-----------------------------------
/* 서브 쿼리 (Subquery)
 * - 쿼리문 안에 다른 쿼리가 포함된 것
 * - 서브쿼리 - 안쪽에 포함된 쿼리
 * - 메인쿼리 - 바깥쪽에 있는 쿼리문
 * 
 * 1) 메인쿼리
 * - 실행의 결과를 보여주는 쿼리문
 * - 일반적으로 서브쿼리에 의해 실행된 결과를 메인에서 사용
 * 
 * 2) 서브쿼리 
 * - 메인쿼리 안쪽에 위치한 쿼리문
 * - 서브쿼리의 결과가 메인쿼리의 조건이나 결과로 사용됨
 * - 서브쿼리의 위치
 * 	* where절
 * 	* having절
 * 	* from절
 * 	* select절
 *  * insert문의 into절 (보류)
 * 	* update문의 set절 
 * 
 * 3) 서브쿼리의 종류
 * 	1. 단일행 서브쿼리 : 서브쿼리가 뱉어내는 값이 1개
 * 	2. 복수행(다중행) 서브쿼리 : 서브쿼리가 뱉어내는 값이 1개 이상
 * 								 여러 개를 비교할 수 있는 연산자를 사용해야 함.
 * 								 IN 연산자, any 연산자(비교연산자), all 연산자,
 * 								 > any, < any, >= any, <= any ...
 *  3. 다중 컬럼 서브쿼리 : 서브쿼리가 뱉어내는 컬럼이 여러 개인 경우
 *  
 *  4. Scalar 서브쿼리
 * 		: SELECT 절의 컬럼 위치에 사용되는 서브쿼리
 * 		: Scalar 서브쿼리는 성능 문제로 이것보다는 join을 사용하는 것이 좋다
 * 		
 *  5. Inline View
 * 		: 서브쿼리가 From절에 기술되는 것
 * 		: 서브쿼리로 조회되는 결과를 테이블로 사용함
 * 		: 서브쿼리에서 조회되는 컬럼에는 별칭을 사용해야 한다.
 * 
 *  6. 상호연관 서브쿼리
 *
 * 
 */

-- [연습] 사원번호가 162번인 사원의 급여와 같은 급여를 받는 직원의 이름, 급여, 부서번호
-- 1) 찾은 값 : 10,500
SELECT salary
FROM hr.employees e 
WHERE employee_id = 162;

-- 2) 찾은 값을 가지고 다시 조회
SELECT first_name, salary, department_id 
FROM hr.employees e 
WHERE salary = 10500;

-- 3) 단일행 서브쿼리로 합치기 (1번의 결과가 하나)
SELECT first_name, salary, department_id 
FROM hr.employees e 
WHERE salary = (SELECT salary
				FROM hr.employees e 
				WHERE employee_id = 162);
			
-- 9. SELF JOIN을 사용하여 'Oliver' 사원의 부서명, 그 사원과 동일한 부서에서 근무하는 동료 사원의 이름을 조회.
-- 단, 각 열의 별칭은 부서명, 동료로 할 것.
SELECT department_id 
FROM hr.employees e 
WHERE first_name = 'Oliver'; -- 80

SELECT first_name, department_name
FROM hr.employees e JOIN hr.departments d 
USING (department_id)
WHERE department_id = (SELECT department_id 
						FROM hr.employees e 
						WHERE first_name = 'Oliver');

-- --------------- <다중행 서브쿼리>
-- 1) IN 연산자의 사용 
-- [연습] 30번 부서의 직급들과 동일한 직급이 다른 팀에도 있는지 조사하는
-- 서브쿼리를 작성하시오					
USE hr;
SELECT DATABASE();


SELECT * FROM hr.employees e 
WHERE job_id IN (SELECT DISTINCT job_id
				 FROM hr.employees e 
				 WHERE department_id = 30);


-- [문제] MySQL에서 제공하는 world database내의 테이블을 확인한 후 전체 인구 Percentage 100%가 공식 언어로
-- 'Spanish'를 사용하는 나라의 이름과 인구를 조회하는 코드를 서브 쿼리를 이용해 작성하시오.
USE world;
SELECT * FROM world.city;
SELECT * FROM world.country;
SELECT * FROM world.countrylanguage c ;
					
					
SELECT name, Population
FROM world.country c
WHERE code IN (SELECT CountryCode
				FROM world.countrylanguage 
				WHERE Percentage = 100
				AND `Language` = 'Spanish');


-- 2) ANY 연산자의 사용
-- [연습] hr데이터베이스에 존재하는 employees 테이블에 'ST_MAN'이라는 직군이 있다.
--        'ST_MAN'이라는 직군이 받는 급여보다 적은 급여를 받는 직원의 정보를 조회
			
-- 전체 데이터 중 가장 큰 값보다 작은 값
SELECT salary
FROM hr.employees e 
WHERE job_id = 'ST_MAN'
ORDER BY 1;
--
SELECT first_name, salary
FROM hr.employees e
WHERE salary > ANY (SELECT salary
					FROM hr.employees e 
					WHERE job_id = 'ST_MAN'
					ORDER BY salary
					)
ORDER BY 2;

-- [연습] job_title이 'Manager'인 직원과 동일한 급여를 받는 직원의
-- 		  사번, 이름, job_id, 급여의 정보를 급여순으로 조회하시오

SELECT first_name, salary, job_title
FROM hr.employees e INNER JOIN hr.jobs j
USING (job_id)
WHERE job_title LIKE '%Manager';
--
SELECT employee_id, first_name, job_id, salary
FROM hr.employees e
WHERE salary = ANY (SELECT salary
					FROM hr.employees e INNER JOIN hr.jobs j
					USING (job_id)
					WHERE job_title LIKE '%Manager')
ORDER BY 4;

-- 3) ALL 연산자의 사용
SELECT salary
FROM hr.employees e 
WHERE job_id = 'ST_MAN'
ORDER BY 1;
--
SELECT first_name, salary
FROM hr.employees e
WHERE salary < ALL (SELECT salary
					FROM hr.employees e 
					WHERE job_id = 'ST_MAN'
					ORDER BY salary
					)
ORDER BY 2;

-- ------------

SELECT first_name, salary, job_title
FROM hr.employees e INNER JOIN hr.jobs j
USING (job_id)
WHERE job_title LIKE '%Manager';
--
SELECT employee_id, first_name, job_id, salary
FROM hr.employees e
WHERE salary < ALL (SELECT salary
					FROM hr.employees e INNER JOIN hr.jobs j
					USING (job_id)
					WHERE job_title LIKE '%Manager'
					ORDER BY salary)
ORDER BY 4;

-- -------------- 다중 컬럼 서브쿼리
-- [연습] 각 부서별 최고 금액을 수령하는 직원의 정보(사원번호, 이름, 급여, 부서명, 직급명)

-- 그룹 함수 : max, min, avg
-- 컬럼이 2개 조회됨
SELECT department_id, max(salary), min(salary) -- 그룹핑할 수 있는 정보들만 select절에 올 수 있음
FROM hr.employees e
GROUP BY department_id;

-- 서브쿼리 사용하기
SELECT e.employee_id, e.first_name, e.salary, d.department_name, j.job_title
FROM hr.employees e
INNER JOIN hr.departments d 
on e.department_id = d.department_id
INNER JOIN hr.jobs j
ON  e.job_id = j.job_id
WHERE (e.department_id, e.salary) IN(SELECT department_id, max(salary)
								FROM hr.employees e
								GROUP BY department_id
								); 
								
-- ------------------ 스칼라 서브쿼리 
-- [연습]

SELECT
	(SELECT last_name FROM hr.employees e2 WHERE first_name='Bruce') AS "Bruce의 성",
	(SELECT last_name FROM hr.employees e2 WHERE first_name='Daniel') AS "Daniel의 성"
FROM hr.employees e 
WHERE first_name = 'David';

-- ------------------ Inline View
-- 일반 조회
SELECT employee_id, first_name, salary, department_id 
FROM hr.employees e 
WHERE department_id = 80;

-- 앞에서 조회된 결과를 이용해서 일련번호를 부여한 후에 출력하려면??

SET @rownum := 0; -- 일련번호를 넣기 위한 사용자 정의 변수
SELECT @rownum := @rownum + 1 AS `no`, tbl.* FROM 
	(SELECT employee_id, first_name, salary, department_id 
	FROM hr.employees e 
	WHERE department_id = 80) tbl;
	
-- ----------------- 상호연관 서브쿼리
-- [연습] 각 부서별로 해당 부서의 급여 평균 미만의 급여를 수령하는 직원 명단 조회
-- (부서번호, 사원번호, 이름, 급여, 부서별 평균급여)
SELECT department_id, employee_id, first_name, salary
FROM hr.employees e
WHERE salary <
			(SELECT avg(salary)
			FROM hr.employees e 
			WHERE department_id = e.department_id);
ORDER BY 1,2;

-- 위 코드를 인라인뷰로 수정하시오
--
SELECT department_id "부서번호", avg(salary) AS "부서평균"
FROM hr.employees e 
GROUP BY department_id ;

-- 인라인뷰안에 넣자!
SELECT e.department_id, e.employee_id, e.first_name, e.salary, round(부서평균)
FROM (SELECT department_id "부서번호", avg(salary) AS "부서평균"
	  FROM hr.employees e 
	  GROUP BY department_id) tbl, hr.employees e -- INNER JOIN한 것 
WHERE tbl.부서번호 = e.department_id
AND e.salary < tbl.부서평균
ORDER BY 1,2;