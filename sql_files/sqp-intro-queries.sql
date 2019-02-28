/*This file is for learning MySQL Workbench and some basic queries */
#Wow another comment

Use exercises;
select * from dams1;

#this query returns name of each dam listed in table dams1
select dam_name
from exercises.dams1

#this query returns name, state, county and inspection date from table dams1
select dam_name, state_name, county, insp_date
from exercises.dams1;

#query returns all fields for all records in table dams1
select * from exercises.dams1;

#returns all fields for all records in dams1 sorted by dam name
select * from exercises.dams1 order by dam_name