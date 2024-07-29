USE hr;
SELECT database();

-- 부서 코드가 50, 80, 100 중의 하나이면서 급여가 7000~8000인 사원들의 이름, 급여, 부서번호를 출력하시오.
SELECT first_name, salary, department_id
FROM hr.employees e
WHERE department_id IN (50, 80, 100)
AND salary BETWEEN 7000 AND 8000;

--  프로그램 실행 날짜를 기준으로 근무한 기간이 17년 미만인 사원들의 이름과 입사 일을 입사일 기준으로 오름차순하여 출력하시오. 
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM hr.EMPLOYEES
WHERE datediff( SYSDATE(), HIRE_DATE) / 365 < 17
ORDER BY 3;

-- 사원 별로 이름과, 급여, 부서 번호 및 자신 부서의 평균 급여를 부서별 오름차순으로 조회하시오. 
-- (단, 부서 평균 급여보다 급여가 많은 직원만 조회되어야 하며  평균 급여는 소수점 2 자리까지 출력)
SELECT first_name AS 이름, last_name AS 성, salary AS 급여, department_id AS 부서번호, round(부서평균, 2) AS "부서 평균 급여"
FROM (SELECT department_id "부서번호", avg(salary) AS "부서평균"
	  FROM hr.employees e 
	  GROUP BY department_id) tbl, hr.employees e -- INNER JOIN한 것 
WHERE tbl.부서번호 = e.department_id
AND e.salary > tbl.부서평균
ORDER BY 4,5;

-- JOB_HISTORY, JOBS 테이블 사용하여 사원 번호, 업무 기간, 업무 명이 출력 되도록 하시오.
-- 업무 기간은 올림으로 처리하시오
SELECT employee_id AS 사원번호, concat(period_diff(date_format(end_date, '%Y%m'), date_format(start_date, '%Y%m')), '개월') AS 업무기간, job_title AS 업무명 
FROM hr.job_history jh JOIN hr.jobs j
ON jh.job_id = j.job_id
ORDER BY employee_id ;

-- 2024년 11월 1일이 수료일이라고 했을 때 오늘 날짜로부터 몇 일 남았는지 출력하는 SQL문장을 작성하시오.
SELECT datediff('20241101', curdate()) AS 남은일수 

-- Scalar subquery 를 사용하여 각 국가명과 속한 지역명을 다음과 같이 조회하시오
SELECT c.country_name AS "국가명",
	(SELECT r.region_name FROM hr.regions r WHERE c.region_id = r.region_id) AS "지역명"
FROM hr.countries c;

--  Employees 테이블에서 매니저가 같은 사원들의 평균급여가 4000이상인 사원의 평균급여, 최대급여, 최소급여를 그림과 같이 출력하시오.
-- 단, 매니저번호가 없는 사원은 0번으로 출력하고, 소수점 이하 올림하시오.
SELECT ifnull(manager_id, 0) AS 매니저번호, round(avg(salary)) AS 평균급여, max(salary) AS 최대급여, min(salary) AS 최소급여
FROM hr.employees e 
GROUP BY manager_id
HAVING 평균급여 >= 4000
ORDER BY 1;

-- 다음은 문구를 취급하는 대형 문구사 재고정보를 관리하는 테이블이다. 주어진 조건의 테이블을 생성하시오. (테이블을 생성하면서 제약조건을 부여하며, 정수형 기본키의 경우 자동 증가하도록 한다.)  
DROP TABLE dima4.Categories;
DROP TABLE dima4.Products;
DROP TABLE dima4.Stocks;

-- 테이블의 생성 
-- 테이블명: Categories (제품 카테고리) 
CREATE TABLE dima4.Categories
(
CATEGORY_ID CHAR(7) CHECK (CATEGORY_ID IN ('WR_PROD','PA_PROD','AR_PROD','ME_PROD','ET_PROD')),
CATEGORY_NAME VARCHAR(30) UNIQUE
						  CHECK (CATEGORY_NAME IN ('필기구','종이류','미술용품','측정용품','기타')),
CATEGORY_DESC VARCHAR(3000) DEFAULT 'None',
CONSTRAINT CATEGORY_ID_PK PRIMARY KEY (CATEGORY_ID)
);

-- 테이블의 생성 
-- 테이블명: Products (제품) 
CREATE TABLE dima4.Products
(
PROD_ID INT AUTO_INCREMENT PRIMARY KEY,
PROD_NAME VARCHAR(30) NOT NULL,
COUNTRY VARCHAR(30) NOT NULL,
MANUFACTURES VARCHAR(50) NOT NULL,
MAKING_DATE DATETIME,
CATEGORY_ID CHAR(7),
CONSTRAINT CATEGORY_ID_FK FOREIGN KEY (CATEGORY_ID)
REFERENCES Categories (CATEGORY_ID)
);

--  테이블의 생성 
-- 테이블명: Stock (재고) 
CREATE TABLE dima4.Stocks
(
STOCK_ID INT AUTO_INCREMENT,
PROD_ID INT REFERENCES Products(PROD_ID)
			ON DELETE CASCADE ON UPDATE CASCADE,
RECEIVE_DATE DATETIME,
FORWARD_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
UNIT_PRICE DECIMAL(10,2),
TOTAL_STOCK DECIMAL(7) DEFAULT 0,
CONSTRAINT STOCK_ID_PK PRIMARY KEY(STOCK_ID),
CONSTRAINT PROD_ID_FK FOREIGN KEY (PROD_ID) REFERENCES Products (PROD_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);
