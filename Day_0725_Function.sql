/* 7월 25일 : Function(함수)의 사용 */

/* 문자열 관련 함수 */

SELECT ascii('A'), char(97); -- 64, a

SELECT bit_length('abc'), char_length('abc'), LENGTH('abc'); -- 3(글자수)*8 = 24, 3, 3

-- 한글은 한 글자당 3byte(24비트)가 필요
SELECT bit_length('가나다'), char_length('가나다'), LENGTH('가나다'); -- 3*24 = 72, 3, 3

SELECT concat('Database',' ','So Good~~');

-- Steven King입니다.
SELECT concat(first_name,' ',last_name,' ','입니다.') AS "소개"
FROM hr.employees e

-- 반복
SELECT repeat('hello', 3);

-- 뒤집기
SELECT reverse('I have a dream!');

-- 위치 찾기 (인덱스가 1부터 시작하므로 찾지 못할 경우에는 0이 반환!)
SELECT locate('hate', 'I hate to turn up out of the blue, uninvited');
SELECT locate('love', 'I hate to turn up out of the blue, uninvited');
-- 3번째 전달값은 찾을 시작위치값
SELECT locate('you', 'Everybody loves the things you do From the way you talk', 35);

-- 데이터를 삽입
SELECT insert('I love you!', 3, 4, 'miss');

-- you를 me로 바꾸시오
SELECT locate('you', 'I love you');
SELECT insert('I love you!', 8, 3, 'me');

-- 위 문장을 하나로 바꾸시오
SELECT insert('I love you!', locate('you', 'I love you!'), 3, 'me');

-- 데이터 추출 : left(개수), right()
-- 왼쪽에서 추출
SELECT LEFT('Everybody loves the things you do From the way you talk', 9);
SELECT RIGHT('Everybody loves the things you do From the way you talk', 4);

-- substring(문자열, 위치, 개수)
SELECT substring('Everybody loves the things you do From the way you talk', 11, 4);

-- 대소문자 변환 
SELECT upper('Everybody loves the things you do From the way you talk'),
		lower('Everybody loves the things you do From the way you talk');
		
-- 치환 : replace(문자열, 찾을 문자열, 바꿀 문자열)
SELECT REPLACE('MSSQL','MS','My');

-- 길이 : length
SELECT length('     I have a dream!!!      ');

-- 문자열 앞 뒤 공백 자르기 : trim(문자열)
SELECT trim('     I have a dream!!!      ');

SELECT length('     I have a dream!!!      '),
		length(trim('     I have a dream!!!      ')),
		length(ltrim('     I have a dream!!!      ')),
		length(rtrim('     I have a dream!!!      '));
		
-- 문자열 앞뒤의 특수문자 자르기 : trim(leading, trailing, both)
SELECT trim(LEADING '~' FROM '~~~I have a dream!!!~~~'),
	   trim(TRAILING '~' FROM '~~~I have a dream!!!~~~'),
	   trim(BOTH '~' FROM '~~~I have a dream!!!~~~');

-- [연습] employee와 departments 테이블을 이용하여 아래와 같이 조회하시오
-- Steve의 부서는 Administration입니다.
-- XXX의 부서는 XXX입니다.
SELECT concat(e.first_name,'의 부서는 ',d.department_name,'입니다.') AS "소개"
FROM hr.employees e INNER JOIN hr.departments d 
ON e.department_id = d.department_id
ORDER BY first_name;

/* 수학 관련 함수 */
SELECT abs(-45.34), abs(45.23); -- 절대값
SELECT floor(-45.653), floor(45.6533); -- 음의 방향에서 만나는 첫번째 정수값
SELECT CEIL(-45.653), CEIL(45.6533); -- 양의 방향에서 만나는 첫번째 정수값 

-- 지정된 소수점 자릿수에서 버림
SELECT truncate(-45.653, 1), truncate(45.6533, 1); 

-- 지정된 소수점 자리 반올림
SELECT round(-45.653, 1), round(45.6533, 1);

-- 전달된 숫자들 중에서 최댓값, 최솟값
SELECT greatest(5, 1, 8, 7, 50) AS "최댓값", least(5, 1, 8, 7, 50) AS "최솟값";

-- 원주율
SELECT pi();

-- 제곱근
SELECT sqrt(81), pow(2.5, 3), power(2, 3.5);

/* 날짜 관련 함수 */
-- 현재 시스템 시간을 조회
SELECT now(), sysdate();

select curdate(), curtime();

-- 날짜 데이터를 연도, 월, 일로 분리해서 조회
SELECT year(sysdate()), month(sysdate()), day(sysdate()); 

-- date(), time() -- 이거보다 curdate(), curtime()를 더 많이 씀
SELECT date(sysdate()), time(sysdate()); 

-- 시, 분, 초
SELECT hour(curtime()), minute(curtime()), second(curtime());

-- 경과시간 : datediff(날짜1, 날짜2)
SELECT datediff('1950-6-25', '1945-8-15');

-- 경과시간 : timediff(미래시간, 과거시간)
SELECT timediff(curtime(), '10:00:00');

-- [연습] 오늘부터 수료일까지 며칠이 남았나요?
SELECT datediff('2024-11-01', curdate());

-- [연습] 센터에 온지 6시간 35분이 지났습니다.
SELECT concat('센터에 온지 ',HOUR(timediff(curtime(), '10:00:00')),'시간 ',
				MINUTE(timediff(curtime(), '10:00:00')),'분이 지났습니다.') AS "오늘";

-- 요일 추출
SELECT dayofweek(sysdate()); -- 5요일(일요일이 1)

-- 월 이름
SELECT monthname(sysdate());

-- 2024년 1월 1일로부터 207일 경과
SELECT dayofyear(sysdate());

/* 기타 함수 */
-- employee의 테이블에서 제공하는 salary를 이용하여 회사 급여 평균을 찾아
-- 변수에 저장한다.
SET @salavg := (SELECT avg(salary) FROM hr.employees e );
SELECT @salavg;

-- 직원의 급여가 평균보다 많은지 아닌지 출력하는 코드를 작성
SELECT first_name, salary, @salavg AS "평균", if(salary > @salavg, "많다", "적다")
FROM hr.employees e;

-- ifnull()을 이용
-- manager_id가 null인 사람은 "팀장이 없음"
SELECT first_name, ifnull(manager_id, "팀장이 없음") 
FROM hr.employees e;

-- [연습] hr.departments 테이블에서 매니저 이름을 출력하시오.
-- 매니저 번호가 없는 경우 "매니저 없음"이라고 출력되도록 하시오
SELECT d.department_id, d.department_name , ifnull(e.first_name , "매니저 없음") AS "Manager Name"
FROM hr.departments d
LEFT OUTER JOIN hr.employees e
ON d.manager_id = e.employee_id;