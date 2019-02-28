--------------------------------------------------------------------------------
--                        The JOIN
--------------------------------------------------------------------------------
-- 1. German Goals

SELECT matchid, player FROM goal
WHERE teamid = 'GER';

-- 2. Which teams played game# 1012

SELECT id, stadium, team1, team2 FROM game
WHERE id = 1012;

-- 3. All the details about German Goals

SELECT player, teamid, stadium, mdate FROM game
JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

-- 4. All the details about Mario's goals

SELECT team1, team2, player FROM game
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%';

-- 5. All the details about goals made in the first 10 min of a game.

SELECT player, teamid, coach, gtime FROM goal
JOIN eteam on (teamid=id)
WHERE gtime<=10;

-- 6. Which games did Fernando Santos coach the home team?

SELECT b.mdate, a.teamname FROM eteam a
JOIN game b ON (b.team1=a.id)
WHERE a.coach='Fernando Santos'
AND b.team1='GRE';

-- 7. Who has scored goals at the National Statium in Warsaw, Poland?

SELECT a.player FROM goal a
JOIN game b ON (a.matchid=b.id)
WHERE b.stadium='National Stadium, Warsaw';

-- 8. Name all players who scored a goal against Germany.

SELECT DISTINCT(player)
FROM game JOIN goal ON (matchid=id)
WHERE (team1='GER' OR team2='GER')
AND teamid <> 'GER';

-- 9. List team and number of goals scored.

SELECT teamname, COUNT(matchid) as Goals FROM eteam
JOIN goal ON (id=teamid)
GROUP BY teamname;

-- 10. Total number of goals scored per Stadium

SELECT Stadium, COUNT(matchid) as Goals FROM game
JOIN goal ON (matchid=id)
GROUP BY stadium;

-- 11. Details for every match with Poland

SELECT matchid, mdate, COUNT(matchid) as Goals
FROM game JOIN goal ON (matchid=id)
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- 12. All details about German Goals

SELECT matchid, mdate, COUNT(matchid) as Goals
FROM game JOIN goal ON (matchid=id)
WHERE (teamid = 'GER')
GROUP BY matchid, mdate;

-- 13. All details for all matches

SELECT mdate, team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT OUTER JOIN goal ON (matchid = id)
GROUP BY mdate, matchid, team1, team2;
