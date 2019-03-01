/*This file is for learning MySQL Workbench and some basic queries */
#Wow another comment

Use exercises;
select * from dams1;

#this query returns name of each dam listed in table dams1
select dam_name
from exercises.dams1

#this query returns name, state, county and inspection date from table dams1
Select dam_name, state_name, county, insp_date
from exercises.dams1;

#query returns all fields for all records in table dams1
select * from exercises.dams1;

#returns all fields for all records in dams1 sorted by dam name
select * from exercises.dams1 order by dam_name desc;

#query returns all record in dams1 sorted by dam_name asc
select * from exercises.dams1 order by dam_name;

select * from exercises.dams1
where COUNTY = "ASHLAND"
Order by dam_name;

select * from exercises.dams1
WHERE YEAR_COMPL = "1969"
ORDER BY DAM_NAME;

/* CAN ALSO USE >, <, <>, BETWEEN, IN, = */
SELECT * FROM exercises.dams1
WHERE YEAR_COMPL >= "1969"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE COUNTY IN ("ASHLAND", "MEDINA", "PERRY")
ORDER BY DAM_NAME;

#DATE TIME FILTERING
SELECT * FROM exercises.dams1
WHERE INSP_DATE = "1995-02-23"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE YEAR(INSP_DATE) = 1995
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE YEAR(INSP_DATE) = 1995
AND COUNTY = "FULTON"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE YEAR(INSP_DATE) = 1995
OR COUNTY = "FULTON"
ORDER BY DAM_NAME;

#USING LIKE AND NOT LIKE FUNCTIONS

SELECT * FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW%"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY LIKE "%BURGH"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY LIKE "%NEW%"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW%TOWN"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW______TOWN"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY NOT LIKE "NEW%"
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE NEAR_CITY NOT IN ("NEWTOWN", "NEWCOMERSTOWN")
ORDER BY DAM_NAME;

#NULL AND NOT NULL

SELECT * FROM exercises.dams1
WHERE YEAR_COMPL <> NULL
ORDER BY DAM_NAME;

SELECT * FROM exercises.dams1
WHERE YEAR_COMPL IS NULL
ORDER BY DAM_NAME;