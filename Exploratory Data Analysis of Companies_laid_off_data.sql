# Exploratory Data Analysis

SELECT * FROM layoffs_copy2;

SELECT 
    MAX(total_laid_off), MAX(percentage_laid_off)
FROM
    layoffs_copy2;
    
SELECT * FROM layoffs_copy2
WHERE total_laid_off >= 12000;    

SELECT * FROM layoffs_copy2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_copy2
WHERE total_laid_off >= 2434;

SELECT company,SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

SELECT industry,SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;

SELECT 
    MIN(`date`), MAX(`date`)
FROM
    layoffs_copy2;

SELECT country,SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS Sum_laid_off
FROM layoffs_copy2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;



WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS Sum_laid_off
FROM layoffs_copy2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1
)
SELECT `MONTH`, Sum_laid_off,SUM(sum_laid_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;



WITH company_Year_laid_off (Company,Years,Total_laid_off) AS
(
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY company,YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC
),  company_rank AS (
SELECT Company,Years,Total_laid_off, DENSE_RANK() OVER (PARTITION BY Years ORDER BY Total_laid_off DESC) AS rank_given
 FROM company_year_laid_off
 WHERE Years IS NOT NULL
)
SELECT * FROM company_rank
WHERE rank_given <= 5;













