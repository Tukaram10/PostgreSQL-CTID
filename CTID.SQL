--CREATE A TABLE 
CREATE TABLE big_table (
    id SERIAL PRIMARY KEY,
    name TEXT,
    salary NUMERIC
);

--INSERT VALUE IN TABLE AS PER COLUMNS

INSERT INTO big_table (name, salary) VALUES
('Alice', 50000),
('Bob', 60000),
('Charlie', 55000),
('Alice', 50000),  -- Duplicate
('Bob', 60000),    -- Duplicate
('Diana', 70000),
('Alice', 50000);  -- Duplicate


--CHECK DUPLICATE  VALUES USING CTID COLUMNS

SELECT ctid, name, salary
FROM big_table
WHERE (name, salary) IN (
    SELECT name, salary
    FROM big_table
    GROUP BY name, salary
    HAVING COUNT(*) > 1
)
ORDER BY name, salary, ctid;


SELECT name, salary
FROM big_table
GROUP BY name, salary
HAVING COUNT(*) > 1;

--DELETE A DUPLICATE VALUE USING CTID COLUMNS 
DELETE FROM big_table
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM big_table
    GROUP BY name, salary
);

--SELECT STATEMENT FOR OUTPUT CHECK 

SELECT MIN(ctid)
FROM big_table
GROUP BY name, salary;

--FINAL OUTPUT 
Id	name	salary
1	Alice	50000
2	Bob  	60000
3	Charlie	55000
6	Diana	70000
