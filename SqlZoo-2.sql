--------------------------------------------------------------------------------
--              SELECT from World Tutorial
--------------------------------------------------------------------------------
-- 1. Introduction, run as is.

SELECT name, continent, population FROM world;

-- 2. Large Countries

SELECT name FROM world
WHERE population >= 200000000;

-- 3. Per Capita GDP

SELECT name, GDP/population AS "per capital GDP" FROM world
WHERE population >= 200000000;

-- 4. South America in millions

SELECT name, population/1000000 FROM world
WHERE continent = 'South America';

-- 5. France, Germany, Italy

SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. United %

SELECT name FROM world
WHERE name LIKE '%United%';

-- 7. Two ways to be BIG!

SELECT name, population, area FROM world
WHERE population > 250000000
OR area > 3000000;

-- 8. One or the other, (but not both!)

SELECT name, population, area FROM world
WHERE population > 250000000
XOR area > 3000000;

-- 9. Rounding

SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2) FROM world
WHERE continent = 'South America';

-- 10. Trillion dollar economies

SELECT name, ROUND(gdp/population, -3) FROM world
WHERE GDP> 1000000000000;

-- 11. Name and capital have the same length

SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12. Matching name and capital

SELECT name, capital FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
AND name <> capital;

--13. All the vowels

SELECT name FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';
