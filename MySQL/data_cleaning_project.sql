-- Data Cleaning Project 


select *
from layoffs;


-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any columns


create table layoffs_staging
like layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

INSERT INTO layoffs_staging
(company, location, total_laid_off, `date`, percentage_laid_off, industry, source, stage, funds_raised, country, date_added)
VALUES
('Clear', 'Bengaluru,Non-U.S.', 145, '2025-08-01', '16%', 'Finance', 'https://entrackr.com/news/clear-cuts-16-of-workforce-amid-peak-tax-filing-season-9628272', 'Series C', '$140', 'India', '2025-08-05'),

('Canva', 'Sydney,Non-U.S.', 10, '2025-04-02', NULL, 'Consumer', 'https://www.afr.com/technology/canva-shocks-employees-with-ai-related-job-cuts-20250331-p5lo06', 'Unknown', '$2500', 'Australia', '2025-04-02'),

('Sure', 'New York City', 70, '2025-02-03', NULL, 'Finance', 'https://www.theinsurer.com/ti/news/embedded-insurtech-sure-slashes-headcount-by-around-70-amid-latest-fundraising-2025-02-03/', 'Series C', '$123', 'United States', '2025-02-05'),

('Hopper', 'Montreal,Non-U.S.', NULL, '2024-11-22', NULL, 'Travel', 'https://skift.com/2024/11/22/hopper-restructures-with-job-cuts-for-the-second-time-in-a-year/', 'Unknown', '$730', 'Canada', '2024-11-24');


select *,
row_number() over(
partition by company,location,total_laid_off,`date`,percentage_laid_off,
industry,stage ,funds_raised,country) as row_num
from layoffs_staging;

with duplicate_cte as(
select *,
row_number() over(
partition by company,location,total_laid_off,`date`,percentage_laid_off,
industry,stage,funds_raised,country) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'Canva';

WITH DELETE_CTE AS 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging
) duplicates
WHERE 
	row_num > 1
)
DELETE
FROM DELETE_CTE
;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from layoffs_staging2
where row_num > 1;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location,total_laid_off,`date`,percentage_laid_off,
industry,stage ,funds_raised,country) as row_num
from layoffs_staging;

-- 1) Temporarily disable safe updates in just this session
SET SQL_SAFE_UPDATES = 0;

-- 2) Do your delete
DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- 3) Re-enable it (optional but recommended)
SET SQL_SAFE_UPDATES = 1;


delete
from layoffs_staging2
where row_num > 1;

SELECT @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

-- 2. Standardize Data
select *
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select distinct location 
from layoffs_staging2
order by 1;
select * 
from layoffs_staging2
where location like 'Vancouver%';
update layoffs_staging2
set location = 'Bengaluru,Non-U.S.'
where location like 'bengaluru%';
select * 
from layoffs_staging2
where location like 'Cayman Islands%';
update layoffs_staging2
set location = 'Cayman Islands'
where location like 'Cayman Islands%';
update layoffs_staging2
set location = 'London,Non-U.S.'
where location like 'London%';
update layoffs_staging2
set location = 'Vancouver,Non-U.S.'
where location like 'Vancouver%';

select distinct country 
from layoffs_staging2
order by 1;

SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y')  AS mmddyyyy_format,
       STR_TO_DATE(`date`, '%Y-%m-%d')  AS yyyymmdd_format
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = CASE
    WHEN `date` LIKE '%/%' THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    WHEN `date` LIKE '%-%' THEN STR_TO_DATE(`date`, '%Y-%m-%d')
    ELSE NULL
END;

update layoffs_staging2
set `date` = DATE;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


SELECT date_added,
       STR_TO_DATE(date_added, '%m/%d/%Y')  AS mmddyyyy_format,
       STR_TO_DATE(date_added, '%Y-%m-%d')  AS yyyymmdd_format
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET date_added = CASE
    WHEN date_added LIKE '%/%' THEN STR_TO_DATE(date_added, '%m/%d/%Y')
    WHEN date_added LIKE '%-%' THEN STR_TO_DATE(date_added, '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE layoffs_staging2
MODIFY COLUMN date_added DATE;

-- 3. Look at Null Values
select * 
from layoffs_staging2;

update layoffs_staging2
set industry = null 
where industry = '';

update layoffs_staging2
set total_laid_off = null 
where total_laid_off = '';

update layoffs_staging2
set percentage_laid_off = null 
where percentage_laid_off = '';

update layoffs_staging2
set funds_raised = null 
where funds_raised  = '';

-- 4. remove any columns and rows we need to
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

delete
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

alter table layoffs_staging2
drop column row_num;

select * 
from layoffs_staging2;





