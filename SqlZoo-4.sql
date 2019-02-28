--------------------------------------------------------------------------------
--                        SELECT within SELECT Tutorial
--------------------------------------------------------------------------------
-- 1. Bigger than Russia

SELECT name FROM world
WHERE population >
     (SELECT population FROM world WHERE name='Russia');

-- 2. Richer than UK

SELECT name FROM world
WHERE GDP/population >
     (SELECT GDP/population FROM world
      WHERE name = 'United Kingdom')
AND continent = 'Europe';

-- 3. Neighbours of Argentina and Australia

SELECT name, continent FROM world
WHERE continent IN
     (SELECT continent FROM world
      WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4. Between Canada and Poland

SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
  AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 5. Percentages of Germany

SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name='Germany'), 0), '%') AS 'population of Germany' FROM world
WHERE continent = 'Europe';

-- 6. Bigger than every country in Europe

SELECT name FROM world
WHERE GDP > (SELECT MAX(GDP) FROM world
             WHERE continent = 'Europe' AND population>0);

-- 7. Largest in each continent

SELECT continent, name, area FROM world x
WHERE area >= (SELECT MAX(area) FROM world y
               WHERE y.continent=x.continent
               AND population>0);

-- 8. First country of each continent (alphabetically).

SELECT continent, name FROM world x
WHERE name <= (SELECT MIN(name) FROM world y
               WHERE y.continent = x.continent);

-- 9. Difficult Questions that utilize techniques not covered in prior sections
-- (first line is correct. )

SELECT name, continent, population FROM world x
WHERE NOT EXISTS
     (SELECT * FROM world y
      WHERE y.continent = x.continent
      AND
      y.population > 25000000)
ORDER BY continent;

-- 10. This country's population is 3x neighbour

Select name, continent FROM world x
WHERE population > ALL (SELECT population*3 FROM world y
WHERE y.continent = x.continent
AND y.name != x.name
AND population > 0)
ORDER BY continent, population DESC;
