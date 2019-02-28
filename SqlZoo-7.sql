--------------------------------------------------------------------------------
--                        The JOIN
--------------------------------------------------------------------------------
-- 1. 1962 Movies

SELECT id, title FROM movie
WHERE yr=1962;

-- 2. When was Citizen Kane released?

SELECT yr FROM movie
WHERE title='Citizen Kane';

-- 3. List Star Trek movies.

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%';

-- 4. id for Glenn Close.

SELECT id FROM actor
WHERE name='Glenn Close';

-- 5. id for Casablanca

SELECT id FROM movie
WHERE title='Casablanca';

-- 6. Case list for Casablanca

SELECT name FROM actor
JOIN casting ON (casting.actorid=actor.id)
WHERE movieid=11768;

-- 7. Alien Cast list

SELECT name FROM actor
INNER JOIN casting ON (casting.actorid=actor.id)
INNER JOIN movie ON (movie.id=casting.movieid)
WHERE title='Alien';

-- 8. Harrison Ford Movies

SELECT title FROM actor
INNER JOIN casting ON casting.actorid=actor.id
INNER JOIN movie ON movie.id=casting.movieid
WHERE name='Harrison Ford';

-- 9. But not as a lead...

SELECT title FROM actor
INNER JOIN casting ON casting.actorid=actor.id
INNER JOIN movie ON movie.id=casting.movieid
WHERE name='Harrison Ford'
AND ord != 1;

-- 10. Lead actors in 1962 Movies

SELECT title, name FROM actor
INNER JOIN casting ON casting.actorid=actor.id
INNER JOIN movie ON movie.id=casting.movieid
WHERE yr = 1962
AND ord = 1;

-- 11. John Travolta, the busy years

SELECT yr,COUNT(title) FROM movie
JOIN casting ON (movie.id=casting.movieid)
JOIN actor   ON (casting.actorid=actor.id)
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON (movie.id=casting.movieid)
         JOIN actor   ON (casting.actorid=actor.id)
 where name='John Travolta'
 GROUP BY yr) AS t);

-- 12. Julie Andrews movies - Who was the leading actor in each?

SELECT DISTINCT(title), name FROM casting
JOIN movie ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE movieid IN
    (SELECT movieid FROM casting
     WHERE actorid IN
           (SELECT id FROM actor
            WHERE name='Julie Andrews'))
AND ord = 1;

-- 13. Actors with more than 30 leading roles.

SELECT name FROM casting
JOIN movie ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE ord=1
GROUP BY name
HAVING COUNT(title) >= 30
ORDER BY name ASC;

-- 14. 1978 films, order by cast size & title

SELECT title, COUNT(actorid) FROM casting
JOIN movie ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;

-- 15. All actors that have worked with Art Garfunkel

SELECT name FROM casting
JOIN movie ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE name !='Art Garfunkel'
AND movieid IN (SELECT movieid FROM casting
JOIN movie ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE name = 'Art Garfunkel');
