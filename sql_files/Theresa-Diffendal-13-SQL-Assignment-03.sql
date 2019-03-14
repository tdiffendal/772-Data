/* Mysql Homework No. 3 (13-Homework)*/
/* Connect to JOURDATA in MySQL Workbench, Then open this file in MySQL Workbench. Rename it Firstname-Lastname-13-SQL-Assignment-12.sql. Work in this file to answer the questions. */
/* Underneath each question below, create a new comment with the correct answer.  Underneath the answer -- NOT in a comment -- put the SQL query you used to derive the answer.*/
/* Use the accidents and deaths tables in the BARD database.
/*Execute this function first: SET SQL_MODE='only_full_group_by';*/
/* Use the documentation in the 13-In-Class-Lab folder*/
/* Submit on ELMS: https://umd.instructure.com/courses/1259604/assignments/4811990 */

SET SQL_MODE='only_full_group_by';

Select * from bard.accidents;
Select * from bard.deaths;

# 1. Write a query to return a table that lists one record per death where alcohol or drug use was listed as a cause of the accident. How many such deaths were there?
#38 deaths
Select a.bardid, a.AccidentCause1, a.AccidentCause2, a.AccidentCause3
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Where (a.AccidentCause1 IN ("Alcohol Use", "Drug Use")
or a.AccidentCause2 IN ("Alcohol Use", "Drug Use")
or a.AccidentCause3 IN ("Alcohol Use", "Drug Use"))
Group by a.bardid, a.AccidentCause1, a.AccidentCause2, a.AccidentCause3;

select AccidentCause1, AccidentCause2, AccidentCause3, count(*)
from bard.accidents
Where (AccidentCause1 IN ("Alcohol Use", "Drug Use")
or AccidentCause2 IN ("Alcohol Use", "Drug Use")
or AccidentCause3 IN ("Alcohol Use", "Drug Use"))
and numberdeaths > 0
group by AccidentCause1, AccidentCause2, AccidentCause3;

# 2. What day of the week has the lowest average age of people killed in accidents?
#Sunday, average deceased age 42
Select a.DayofWeek, avg(d.DeceasedAge)
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Group by a.DayofWeek
Order by avg(d.DeceasedAge) asc;

# 3: What percentage of people killed on the Potomac River were wearing life jackets?
#66%, or 2/3
Select a.NameOfBodyOfWater, d.DeceasedPFDWorn
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Where a.NameOfBodyOfWater like "%Pot%"
Group by a.NameOfBodyOfWater, d.DeceasedPFDWorn;

#Actual correct code: 12/22 instances a life jacket was worn
select DeceasedPFDWorn, count(*) 
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Where a.NameOfBodyOfWater like "%Pot%"
group by d.DeceasedPFDWorn;

# 4: You're writing a story about the role alcohol plays in boating accidents and are looking for a detail for a story. A Coast Guard source tells you he remembered an accident that caused thousands of dollars in damage after the occupants downed more than a dozen small tubs of beer (an average one of these containers holds about 6 bottles of beer) at a bar before hitting the water some time in the last decade.  You try to find it in the data. How many of these tubs did they pay for?
#17 buckets of beer, probably a better way to do it since I read many narratives
select a.RedactedNarrative, a.TotalDamage, a.AccidentCause1, a.AccidentCause2, a.AccidentCause3 
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Where (a.AlcoholInvolved = "Yes"
or a.AccidentCause1 like "%Alcohol%"
or a.AccidentCause2 like "%Alcohol%"
or a.AccidentCause3 like "%Alcohol%")
Group by a.RedactedNarrative, a.TotalDamage, a.AccidentCause1, a.AccidentCause2, a.AccidentCause3 
Order by a.TotalDamage desc;

select * from bard.accidents
where RedactedNarrative like "%bar%"
and TotalDamage > 0
and AlcoholInvolved = "yes"
order by TotalDamage desc;

# 5: How many accidents were there where at least one person who wasn't the operator of a boat (an occupant) died?
#76 deaths, 67 accidents
#Check if the things you're grouping on are unique but selecting that column and running a count(*)
select a.bardid
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Where (d.DeceasedRole <> "Operator" or d.DeceasedRoleOther <> "Operator")
group by a.bardid;


select * from bard.deaths;
select * from bard.accidents;

# 6 - #8 Think of three interesting questions to ask and answer of the data.  At least two of them should join accidents to the death table.

#What state saw the most deaths? - Maryland with 133
select a.state, count(a.numberdeaths)
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
group by a.state
order by count(a.numberdeaths) desc;

#How many deaths were on a clear day when a lifevest wasn't worn? - 19 times
select count(*)
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
where a.Clear = "-1"
and d.DeceasedPFDWorn = "-1";

#what was the average age of those who died when alcohol was involved? 
#When involved 39.22, when not involved 48.2
select a.AlcoholInvolved, avg(d.DeceasedAge)
From bard.accidents a Join bard.deaths d on a.bardid = d.bardid
Group by a.AlcoholInvolved;