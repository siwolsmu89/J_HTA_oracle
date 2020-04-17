-- 자바에서는 덧셈기호가 이어붙이기로 동작했지만 oracle에서는 ||가 이어붙이는 기호다.
-- concat 보다 좋은 점 : ||는 다수의 문자를 이어붙일 수 있어서 공백을 줄 수도 있음.
select first_name ||' ' || last_name  
from employees;

-- 연산절을 select에 적을 때, where 조건절 없이 적으면 행에 대한 제한이 없음
-- 그러면 그 테이블에 있는 모든 행을 가져오는데, 값은 우리가 지정한 연산식의 결과를 표시하게 된다.
select substr('891027', 3, 2)
from employees;

-- 그래서 oracle에서는 1행1열짜리 테이블인 dual을 만들어 둠 (column dummy, 값은 x)
-- 이 테이블은 내가 뭔가 계산 결과를 한 번만 나타내보고 싶을 때 사용하는 테이블(엄청 많이 사용됨)
select *
from dual;

select instr('010-7942-4465', '-')
from dual;

-- 주소에서 앞부분만 잘라서 출력하기
select street_address, substr(street_address,1,instr(street_address,' ')-1)
from locations;

select replace(first_name, 'a', 'A')
from employees;

-- 숫자함수
select
    round(1265.737,2) "2",
    round(1265.737,1) "1",
    round(1265.737,0) "0",
    round(1265.737) " ",
    round(1265.737,-1) "-1",
    round(1265.737,-2) "-2"
from dual;

select
    trunc(1265.737,2) "2",
    trunc(1265.737,1) "1",
    trunc(1265.737,0) "0",
    trunc(1265.737) " ",
    trunc(1265.737,-1) "-1",
    trunc(1265.737,-2) "-2"
from dual;

-- 직원들의 시급을 조회하기
-- 직원아이디, 이름, 직종아이디, 급여, 시급
-- 시급 = 급여*환율/40, 시급은 원단위까지만 표시한다
select employee_id, first_name, job_id, salary, trunc(salary*1220.40/(5*8)) pay_for_hour
from employees
order by pay_for_hour desc;

-- 나머지값 구하기
select mod(32, 5)
from dual;

-- 날짜 함수
-- 현재 날짜와 시간정보 조회하기
select sysdate
from dual;

-- 직원아이디, 직원명, 입사일, 오늘까지 근무한 날짜
select 
    employee_id, first_name, hire_date
    , trunc(sysdate-hire_date) as worked_days
    , trunc(trunc(sysdate-hire_date)/365) as worked_years
from employees
order by worked_days desc;

-- 오늘, 3일전, 1주일전, 1개월전, 3개월전
select sysdate "지금"
    , sysdate -1 "1일 전"
    , sysdate -7 "1주일 전"
    , sysdate -30 "한달 전"
from dual;

-- 60번 부서에 소속된 사원들의 아이디, 이름, 입사일, 근무한 개월수를 조회하기
-- 개월수는 소수점부분을 버린다.
select employee_id
    , first_name
    , hire_date
    , trunc(months_between(sysdate, hire_date)) as worked_months
    , trunc(months_between(sysdate, hire_date)/12, 1) as worked_years
from employees
where department_id=60
order by worked_months;

-- 오늘부터 3개월 후의 날짜는?
select add_months(sysdate, 3) as "3 months later"
from dual;

-- 오늘부터 1년 전의 날짜는
select add_months(sysdate, -12) as "1 year before"
from dual;

-- 날짜 반올림하기, 버리기
select sysdate+0.5, round(sysdate+0.5), trunc(sysdate+0.5)
from dual;

-- 
select firsT_name, hire_date
from employees;

-- 두 날짜의 일수 계산하기
-- 현재 날짜에 대해 trunc() 함수로 시분초를 모두 0으로 만들어서 날짜 연산을 했다.
select employee_id
    , first_name
    , hire_date
    , sysdate - hire_date
    , trunc(sysdate)-hire_date
from employees;

-- 이번달의 마지막 날 조회하기
select last_day(trunc(sysdate)) , last_day(sysdate)
from dual;

-- 오늘을 기준으로 다음 번 토요일
-- next_day(기준날짜, 요일번호) : 다음 특정한 요일이 언제인지를 알려 주는 함수
-- 요일번호는 1~7(일요일~토요일)
select next_day(trunc(sysdate), 7)
from dual;

-- 오늘을 기준으로 다음 번 금요일
select next_day(trunc(sysdate), 6)
from dual;

-- 오늘을 기준으로 다음 번 일요일
select next_day(trunc(sysdate), 1)
from dual;

select to_date('09-10-27')+4000 as "4000days"
from dual;

-- 변환 함수
-- 날짜를 문자로 변환하기
select to_char(sysdate, 'yyyy') as 연도
    , to_char(sysdate, 'mm') as 월
    , to_char(sysdate, 'dd') as 일
    , to_char(sysdate, 'day') as 요일
    , to_char(sysdate, 'am') as "오전/오후"
    , to_char(sysdate, 'hh') as 시간
    , to_char(sysdate, 'hh24') as "시간(24)"
    , to_char(sysdate, 'mi') as 분
    , to_char(sysdate, 'ss') as 초
from dual;

-- 2003년도에 입사한 사원의 아이디, 이름, 입사일 조회
select employee_id, first_name, to_char(hire_date, 'mm') as hire_month
from employees
where to_char(hire_date, 'yyyy') = '2003';

-- 입사일이 오늘 날짜와 같은 날짜에 입사한 직원의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mmdd') = to_char(sysdate, 'mmdd');

-- 특정날짜를 나타내는 문자를 날짜(DATE타입)로 변환하기
select to_date('2018-12-31', 'yyyy-mm-dd') +1000
from dual;

-- 특정날짜를 나타내는 문자를 날짜로 변환해서 오늘까지의 일수, 개월수를 조회하기
select trunc(sysdate) - to_date('1989-10-27', 'yyyy-mm-dd') as days
    , trunc(months_between(trunc(sysdate), to_date('1989-10-27', 'yyyy-mm-dd'))) as months
from dual;