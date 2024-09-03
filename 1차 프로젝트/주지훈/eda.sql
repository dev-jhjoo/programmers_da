-- 일별 코로나 확진자 데이터를 월별로 조회
select
    concat(year, '-', month) as date,
    sum(total_confirmed_cases) as total_confirmed_cases,
    sum(domestic_confirmed_cases) as domestic_confirmed_cases,
    sum(imported_confirmed_cases) as imported_confirmed_cases,
    sum(death_cases) as death_cases
from covid19_confirmed_records
group by year, month
;
-- 월별 코로나 확진자 & 누적
with monthly_covid19 as (
    select
        concat(year, '-', month) as date,
        sum(total_confirmed_cases) as total_confirmed_cases,
        sum(domestic_confirmed_cases) as domestic_confirmed_cases,
        sum(imported_confirmed_cases) as imported_confirmed_cases,
        sum(death_cases) as death_cases
    from covid19_confirmed_records
    group by year, month
)
select date
     , total_confirmed_cases
     , sum(sum(total_confirmed_cases)) over (order by date) as cumulative_total
from monthly_covid19
group by 1
order by 1
;
-- 관광수입 & 누적 확진자 수
with covid19 as (
    select
        year,
        month,
        sum(total_confirmed_cases) as monthly_confirmed_cases
    from covid19_confirmed_records
    group by 1, 2
)
select
    a.year,
    a.month,
    concat(a.year, '-', a.month) as form_date,
    tourism_receipts,
    sum(sum(b.monthly_confirmed_cases)) over (order by b.year, b.month) as monthly_confirmed_cases
from tourism_revenue a
left outer join covid19 b
    on a.year = b.year and a.month = b.month
group by 1, 2
order by 1, 2
;

-- 내,외국인 지출 합계
select
    year
    , cast(month as unsigned ) as month
    , concat(year, '-', month) as my_date
    , category
    , sum(paid_amount) as total_paid_amount
from expenditure_details
group by 1, 2, 3, 4
order by 1, 2
;

-- 업종별 지출액 avg
select
    category,
    round(avg(paid_amount), 0) as avg_paid_amount,
    rank() over (order by round(avg(paid_amount), 0) desc) as rk
from expenditure_details
group by category
;

-- 방문자 및 지출액 증감율
with base as (
    select
        date,
        tourist,
        ifnull(LEAD(tourist) over (order by date), 0) as next_tourist,
        paid_amount,
        ifnull(LEAD(paid_amount) over (order by date), 0) as next_paid_amount
    from tourist
)
select
    date,
    tourist,
    next_tourist,
    round(((next_tourist - tourist)/tourist)* 100, 2) as tourist_rate,
    paid_amount,
    next_paid_amount,
    round(((next_paid_amount - paid_amount)/paid_amount)* 100, 2) as paid_amount_rate
from base
;

-- 월별 해외관광객
with next_tourist as (
    select
        date,
        tourist,
        LEAD(tourist) over (order by date) as next_tourist
    from overseas_tourist
)
select
    date,
    tourist,
    next_tourist,
    round(((next_tourist - tourist)/tourist) * 100,2) as increas_rate
from next_tourist
;
;