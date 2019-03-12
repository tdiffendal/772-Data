#Theresa Diffendal March 12, 2019

set sql_mode='only_full_group_by';

Select *
from bard.accidents;

Select bardid, count(*) as count
From bard.accidents
group by bardid
order by count desc;

Select *
from bard.deaths;

Select bardid, count(*) as count
From bard.deaths
group by bardid
order by count desc;

Select *
from bard.deaths
where bardid = "MD-2016-0161";

Select *
from bard.accidents
where bardid = "MD-2016-0161";

#intro to join statements
Select *
from bard.accidents JOIN bard.deaths on bard.accidents.bardid = bard.deaths.bardid
WHERE bard.accidents.bardid = "MD-2016-0161";

select * from bard.accidents;
select * from bard.deaths;

#from and join sequence will return similar results, but columns in different order
select * 
from bard.accidents JOIN bard.deaths on bard.accidents.bardid = bard.deaths.bardid;
select * 
from bard.deaths JOIN bard.accidents on bard.deaths.bardid = bard.accidents.bardid;

#renaming tables
select * 
from bard.deaths as d JOIN bard.accidents as a on d.bardid = a.bardid;

select d.bardid, d.CauseOfDeath, d.DeceasedRole, a.Year
from bard.deaths d join bard.accidents a on d.bardid = a.bardid;

SELECT *
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
WHERE d.DeceasedAge < 18 AND a.YEAR = '2016';

select a.year, d.CauseofDeath, COUNT(*) as count
From bard.deaths d join bard.accidents a on d.bardid = a.bardid
Group by a.year, d.CauseofDeath
Order by a.year, d.CauseofDeath;

#Wanted to see what accident causes led to what deaths and how many times
select a.AccidentCause1, d.CauseofDeath, count(*) as count
From bard.deaths d join bard.accidents a on d.bardid = a.bardid
group by a.AccidentCause1, d.CauseofDeath
order by count desc;

#What age did different accident causes impact, on average
select a.AccidentCause1, avg(d.DeceasedAge) as Average_Deceased_Age, count(*) as count
From bard.deaths d join bard.accidents a on d.bardid = a.bardid
group by a.AccidentCause1
order by Average_Deceased_Age desc;

#Did weather impact cause of death?
select a.clear, d.CauseofDeath, count(a.clear) as Number_Incidents 
From bard.accidents a join bard.deaths d on a.bardid = d.bardid
Group by a.clear, d.CauseofDeath;
