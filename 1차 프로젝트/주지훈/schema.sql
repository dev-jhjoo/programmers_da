CREATE TABLE `covid19_confirmed_records` (
  `year` text COMMENT '년도',
  `month` text COMMENT '월',
  `day` text COMMENT '일',
  `total_confirmed_cases` int DEFAULT NULL COMMENT '총 감염자 수',
  `domestic_confirmed_cases` int DEFAULT NULL COMMENT '국내 감염자 수',
  `imported_confirmed_cases` int DEFAULT NULL COMMENT '해외입국 감염자 수',
  `death_cases` int DEFAULT NULL COMMENT '사망자 수'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='코로나 확진자 기록'
;

CREATE TABLE `domestic_policy` (
  `policy_name` text COMMENT '정책명',
  `start_date` text COMMENT '시작일',
  `end_date` text COMMENT '종료일'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='코로나 관련 국가 정책'
;

CREATE TABLE `expenditure_details` (
  `year` text COMMENT '년도',
  `month` text COMMENT '월',
  `category` text COMMENT '업종',
  `is_korean` tinyint(1) DEFAULT NULL COMMENT '내외국인 구분',
  `paid_amount` bigint DEFAULT NULL COMMENT '지출액'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='내외국인 지출 내역'
;

CREATE TABLE `overseas_tourist` (
  `year` text COMMENT '년도',
  `month` text COMMENT '월',
  `date` text COMMENT '일자',
  `tourist` bigint DEFAULT NULL COMMENT '해외 관광객 수'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='외국인 관광객'
;

CREATE TABLE `tourism_revenue` (
  `year` varchar(4) DEFAULT NULL COMMENT '년도',
  `month` varchar(2) DEFAULT NULL COMMENT '월',
  `tourism_receipts` bigint DEFAULT NULL COMMENT '관광수입(단위: usd)',
  `tourism_expenditure` bigint DEFAULT NULL COMMENT '관광지출(단위: usd)',
  `tourism_balance` bigint DEFAULT NULL COMMENT '관광수지(단위: usd)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관광수익'
;

CREATE TABLE `tourist` (
  `year` text COMMENT '년도',
  `month` text COMMENT '월',
  `date` text COMMENT '일자',
  `tourist` bigint DEFAULT NULL COMMENT '방문자(외지인+외국인)',
  `paid_amount` double DEFAULT NULL COMMENT '지출액'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='국내 여행객'
;