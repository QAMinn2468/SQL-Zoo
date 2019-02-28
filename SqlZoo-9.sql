--------------------------------------------------------------------------------
--                        Self JOIN
--------------------------------------------------------------------------------
-- 1.  Total stops

SELECT COUNT(id) FROM stops;

-- 2. ID for 'Craiglockhart'

SELECT id FROM stops
WHERE name='Craiglockhart';

-- 3. Details for '4''LRT'

SELECT id, name FROM stops
JOIN route ON (stops.id=route.stop)
WHERE route.num='4'
AND route.company='LRT';

-- 4. Routes and stops

SELECT company, num, COUNT(*) AS stops
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING stops>1;

-- 5. Self JOIN

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name='London Road';

-- 6. Find the routes that join the two stops.

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name='London Road';

-- 7. Using a self join

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.id='115'
AND stopb.id='137';

--8. Same, with different stops

SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name='Tollcross';

-- 9. Start your trip at "Craiglockhart", where could you go?

SELECT DISTINCT stopb.name, b.company, b.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND b.company='LRT';

-- 10. Person A lives in "Craiglockhart", Person B lives in "Sighthill", they each take 1 bus to a meeting point. Where could they meet?

SELECT DISTINCT a.num, a.company, stopb.name, c.num, c.company
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
  JOIN stops stopc ON (c.stop=stopc.id)
  JOIN stops stopd ON (d.stop=stopd.id)
WHERE stopb.name=stopc.name
AND stopa.name='Craiglockhart'
AND stopd.name='Lochend';
