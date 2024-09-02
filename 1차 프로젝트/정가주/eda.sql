SELECT * FROM analysis.statistics;


2) 관광객 수 변화 에 따른 소비액 비교
 - 내국인
 - 외국인
;

select * from 
analysis.visitor v join  
(select year
     , area
	 , sum(amount) as year_sum
  from analysis.statistics
  group by year,area) s
  on v.year = s.year and v.area = s.area
;

-- 핵심,부분으로 구별된 관광 사업체 수 (년도지역별)
select year,area,integrate,sum(count) as sum_cnt
  from (
select year
    , area
	, case 
		  when part = '여행업' then '핵심'
          when part = '관광숙박업' then '핵심'
          when part = '국제회의업' then '핵심'
          when part = '카지노업' then '핵심'
          when part = '관광편의시설업' then'핵심'
		  else '부분'
       end as integrate
	, count
	from analysis.part) as temp
    group by year, area, integrate
;

select year,area,integrate,sum(amount) as sum_amt
  from (
select  year
    , area
    ,  case 
		  when part = '여행업' then '핵심'
          when part = '여가서비스업' then '핵심'
		  else '부분'
       end as integrate
    , amount
  from analysis.statistics
  ) as temp2
  group by year, area, integrate
  
  
  
  
  
  
  ;
  
  
  WITH a AS (
   select year,area,integrate,sum(count) as sum_cnt
  from (
select year
    , area
	, case 
		  when part = '여행업' then '핵심'
          when part = '관광숙박업' then '핵심'
          when part = '국제회의업' then '핵심'
          when part = '카지노업' then '핵심'
          when part = '관광편의시설업' then'핵심'
		  else '부분'
       end as integrate
	, count
	from analysis.part) as temp
    group by year, area, integrate

),
b AS (
select year,area,integrate,sum(amount) as sum_amt
  from (
select  year
    , area
    ,  case 
		  when part = '여행업' then '핵심'
          when part = '여가서비스업' then '핵심'
		  else '부분'
       end as integrate
    , amount
  from analysis.statistics
  ) as temp2
  group by year, area, integrate
)

select a.year
    , a.area
    , a.integrate
	, sum_cnt
    , sum_amt
 From 
  a join b on (a.year = b.year and a.area = b.area and a.integrate = b.integrate);
  

;


select year
    , area
	, sum(count) as sum_cnt
	from analysis.part
    group by year,area
    ;

select year
     , area
	 , sum(amount) as year_sum
  from analysis.statistics
  group by year,area
  
  
  ;
  
  
  WITH a AS (
   select year
    , area
	, sum(count) as sum_cnt
	from analysis.part
    group by year,area
),
b AS (
select year
     , area
	 , sum(amount) as year_sum
  from analysis.statistics
  group by year,area
)
select a.year
    , a.area
	, a.sum_cnt as part_sum
    , b.year_sum as consume_sum
  from a join b on (a.year = b.year and a.area = b.area)