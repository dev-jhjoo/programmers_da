-- 년도별 전체 평균
SELECT
    AVG(`2018`) AS avg_2018,
    AVG(`2019`) AS avg_2019,
    AVG(`2020`) AS avg_2020,
    AVG(`2021`) AS avg_2021,
    AVG(`2022`) AS avg_2022,
    AVG(`2023`) AS avg_2023
FROM
    test2;

-- 나라별 년도별 전체 평균
SELECT
    EU,
    AVG(`2018`) AS avg_2018,
    AVG(`2019`) AS avg_2019,
    AVG(`2020`) AS avg_2020,
    AVG(`2021`) AS avg_2021,
    AVG(`2022`) AS avg_2022,
    AVG(`2023`) AS avg_2023
FROM
    test2
group by EU ;

-- kr_trafic
SELECT 
    Time, 
    Airport_inchun, 
    Airport_Kimpo, 
    Airport_Kimhea, 
    Airport_Jeju, 
    Airport_others, 
    Port_others
FROM 
    kr_traffic;

-- year location+total visitor sum
SELECT EXTRACT(YEAR FROM Time) AS Year, location, SUM(Total_Visitors) AS Total_Visitors
FROM 2_mobile_visitor_e
GROUP BY Year, location
ORDER BY Year, location;

-- year locationforeignVisitors ratio
SELECT EXTRACT(YEAR FROM Time) AS Year, location, 
       SUM(Foreign_Visitors) AS Foreign_Visitors,
       SUM(Total_Visitors) AS Total_Visitors,
       (SUM(Foreign_Visitors) / SUM(Total_Visitors)) * 100 AS Foreign_Visitor_Ratio
FROM 2_mobile_visitor_e
GROUP BY Year, location
ORDER BY Year,   
		CASE location
           WHEN 'Seoul' THEN 1
           WHEN 'Busan' THEN 2
           WHEN 'Incheon' THEN 3
           WHEN 'Daegu' THEN 4
           WHEN 'JejuIsland' THEN 5
           ELSE 6
         END;

-- Monthly visitors comparison
SELECT 
    CONCAT(SUBSTRING(Time, 1, 4), '-', LPAD(SUBSTRING(Time, 6), 2, '0')) AS Month, 
    location, 
    SUM(Total_Visitors) AS Total_Visitors
FROM 
    2_mobile_visitor_e
GROUP BY 
    CONCAT(SUBSTRING(Time, 1, 4), '-', LPAD(SUBSTRING(Time, 6), 2, '0')), 
    location
ORDER BY 
    CONCAT(SUBSTRING(Time, 1, 4), '-', LPAD(SUBSTRING(Time, 6), 2, '0')), 
    location;