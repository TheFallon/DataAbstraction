/*  Connect By  */

/* Create a recursive list showing the reporting structure for the consultants */

-- The following query shows who reports to whom, but the output is hard to recognize
SELECT 
   LEVEL,
   consultant_id,
   first_name,
   last_name
FROM consultant
  START WITH boss_id IS NULL
connect by prior consultant_id = boss_id;


-- The following uses lpad to increase the indent for each level of reporting structure
SELECT 
   lpad(' ',2*(LEVEL-1)) || first_name || ' ' || last_name AS s 
FROM consultant 
  START WITH boss_id IS NULL
CONNECT BY PRIOR consultant_id = boss_id
;