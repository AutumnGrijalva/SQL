WITH char_data AS (
  SELECT 72 AS a UNION ALL
  SELECT 101 UNION ALL
  SELECT 108 UNION ALL
  SELECT 108 UNION ALL
  SELECT 111 UNION ALL
  SELECT 32 UNION ALL
  SELECT 119 UNION ALL
  SELECT 111 UNION ALL
  SELECT 114 UNION ALL
  SELECT 108 UNION ALL
  SELECT 100 UNION ALL
  SELECT 46
)
, gen AS (
  SELECT 1 AS rn 
  UNION ALL
  SELECT rn + 1 
  FROM gen
  WHERE rn < LENGTH('Hello world.')
)
SELECT msg AS output
FROM (
  SELECT almost AS msg
    , MIN(rn) min_rn
  FROM (
    SELECT LISTAGG(closer,'') AS almost 
        , rn
    FROM (
      SELECT CHAR(a) AS closer
        , rn
      FROM char_data
      CROSS JOIN gen
         ) initial_step_data
    GROUP BY rn
        )main_query_data
  GROUP BY almost
  ) limit_rows
WHERE min_rn = 1;


WITH hello AS (
	SELECT rw, msg
	FROM (VALUES 
		(1, 72), (2, 101), (3, 108), (4, 108), (5, 111), (6, 32)
		, (7, 119), (8, 111), (9, 114), (10, 108), (11, 100), (12, 33)
	    ) AS v (rw, msg)
)
, world AS (
	SELECT rw, CHR(msg) msg
	FROM hello
	ORDER BY rw
)
SELECT * FROM world 
PIVOT (MAX(msg) FOR rw IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12))
    ;

WITH a AS (SELECT '48656C6C6F')
, b AS (SELECT '576F726C64')
, c AS (
	SELECT CONCAT(a.*,'20',b.*,'21') msg
	FROM a CROSS JOIN b)
SELECT HEX_DECODE_STRING(msg) msg FROM c
;
