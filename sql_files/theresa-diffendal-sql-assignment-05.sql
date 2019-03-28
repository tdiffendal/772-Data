#Theresa Diffendal sql lab 05
# the role of alcohol in boating accidents
# use: SELECT	FROM		ORDER BY		LIKE with a wildcard	GROUP BY		AS	
#COUNT, AVERAGE, SUM, MIN and MAX	JOIN		HAVING 		WITH ROLLUP
#from the data available, specifically the large amount of null values, I don't know if I can draw any strong conclusions about alcohol use in accidents.

SET SQL_MODE='only_full_group_by';

Select * from bard.accidents;
Select * from bard.deaths;
select * from bard.vessels;

#15 deaths where the deceased's BAC > 0; mode is .090, greatest is .340, lowest .020
select * from bard.deaths
where deceasedbac > 0;

#123 counts of alcohol use, eigth most common cause
select accidentcause1, count(*)
from bard.accidents
group by accidentcause1;

#10 counts alcohol use
select accidentcause2, count(*)
from bard.accidents
group by accidentcause2;

#9 counts of alcohol use
select accidentcause3, count(*)
from bard.accidents
group by accidentcause3;

#no mention of alcohol use
select otheraccidentcause, count(*)
from bard.accidents
group by otheraccidentcause;

#how many accidents did alcohol use cause? - 142 returned records
select * from bard.accidents
where accidentcause1 like "%alcohol%"
or accidentcause2 like "%alcohol%"
or accidentcause3 like "%alcohol%";

#how many accidents where alcohol used and resulted in death - 33 records
select * from bard.accidents
where (accidentcause1 like "%alcohol%"
or accidentcause2 like "%alcohol%"
or accidentcause3 like "%alcohol%")
and numberdeaths > 0;

#1515 null, 994 N, 112 Y
select operatorusingalcohol, count(*)
from bard.vessels
group by operatorusingalcohol;

#alcohol has a greater average damage - 12,936 - compared to N (7314.7) and null (9213.8). But despite having the greatest average damage, incidents involving an operator using alcohol had the least total/sum damage. Greatest max damage goes to a null scenario, racking up 2,500,000
select operatorusingalcohol, avg(damagetovessel), min(damagetovessel), max(damagetovessel), sum(damagetovessel), count(*)
from bard.vessels
group by operatorusingalcohol;

#open motorboat and cabin motorboats were most used when alcohol involved (44 and 40)
select vesseltype, count(*)
from bard.vessels
where operatorusingalcohol = "Y"
or BAC > 0
group by vesseltype;

#119 injured in "null" situations, 266 when operator not using alcohol, 29 when operator using alcohol
select operatorusingalcohol, count(numberinjured)
from bard.vessels
group by operatorusingalcohol;

#three operators with 10 to 100 hours experience had bac > 0, two with 101 to 500 hours, and two unknowns
select operatorexperience, bac, count(*)
from bard.vessels
group by operatorexperience, bac;

#operators with over 500 hours were most likely to have used alcohol (33 incidents), compared to 30 for those with 101 to 500 hours, 19 with 10 to 100 hours. 24 were unknown. Again, lots of null values
select operatorexperience, operatorusingalcohol, count(*)
from bard.vessels
group by operatorexperience, operatorusingalcohol;

#1515 instances where operatorusingalcohol had a null value, 994 for no, 112 for yes; 2621 incidents overall
select operatorusingalcohol, operatorexperience, count(*)
from bard.vessels
group by operatorusingalcohol, operatorexperience with rollup;

#1 trauma, 4 unknown, 10 drowning
select causeofdeath, count(*) as numberincidents
from bard.deaths
where deceasedbac > 0
group by causeofdeath
order by numberincidents;

#number one incident skier mishap, then collision with fixed object
select accidentevent1, count(*)
from bard.accidents
group by accidentevent1
order by count(*) desc;

#collision with fixed object hightest number of incidents, then collision with recreational vessel; as opposed to the last query, skier mishap accounted for relatively few incidents - only 3 - which possibly suggests people using alcohol are less likely to go water skiing? And drunk people can't drive
select accidentevent1, count(*)
from bard.accidents
where alcoholinvolved = "Yes"
group by accidentevent1
having count(*) > 0
order by count(*) desc;

#only one incident, an adult
select d.year, if(d.deceasedage < 13, "child", if(d.deceasedage <= 19, "teen", "adult")) as age, count(*)
From bard.deaths d join bard.vessels v on d.bardid = v.bardid
where v.operatorusingalcohol  = "Y" 
and v.vesseltype = "personal watercraft"
group by d.year, age;

#29 incidents, still all adults, with a large gap between 2005 and 2014
select d.year, if(d.deceasedage < 13, "child", if(d.deceasedage <= 19, "teen", "adult")) as age, count(*)
From bard.deaths d join bard.vessels v on d.bardid = v.bardid
where v.operatorusingalcohol  = "Y" 
group by d.year, age;

#2011 and 2015 reached or surpassed 20 deaths, while the other years range from 10-16 deaths
select year, count(*)
from bard.accidents
where numberdeaths > 0
group by year;