--------------------------------------------------------------------------------
--                        Using NULL
--------------------------------------------------------------------------------
-- 1. NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN

SELECT teacher.name FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id)
WHERE dept.name IS NULL;

-- 2. INNER JOIN

SELECT teacher.name, dept.name FROM teacher
INNER JOIN dept ON (teacher.dept=dept.id);

-- 3. LEFT JOIN

SELECT teacher.name, dept.name FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id);

-- 4. RIGHT JOIN

SELECT teacher.name, dept.name FROM teacher
RIGHT JOIN dept ON (teacher.dept=dept.id);

-- 5. COALESCE

SELECT teacher.name, COALESCE(mobile, '07986 444 2266') AS mobile FROM teacher;

-- 6. COALESCE & LEFT JOIN

SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id);

-- 7. COUNT

SELECT COUNT(teacher.name), COUNT(teacher.mobile) FROM teacher;

-- 8. COUNT & GROUP BY

SELECT dept.name, COUNT(teacher.name) FROM teacher
RIGHT JOIN dept ON (teacher.dept=dept.id)
GROUP BY dept.name;

-- 9. Case

SELECT teacher.name,
CASE
    WHEN dept=1 THEN 'Sci'
    WHEN dept=2 THEN 'Sci'
    ELSE 'Art'
END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept);

-- 10. More Cases

SELECT teacher.name,
CASE
    WHEN dept=1 THEN 'Sci'
    WHEN dept=2 THEN 'Sci'
    WHEN dept=3 THEN 'Art'
    ELSE 'None'
END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept);
