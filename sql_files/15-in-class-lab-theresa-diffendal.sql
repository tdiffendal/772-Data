#Theresa Diffendal, session 15 in class lab
SET SQL_MODE='only_full_group_by';

Select * from bard.accidents;
Select * from bard.deaths;
select * from bard.vessels;

#Things to look at:
# From bard.accidents a Join bard.deaths d join bard.vessels v on a.bardid = d.bardid = v.bardid
# where operatorexperience is not ("no experience" or "no operator" or "unknown")

select year(a.date), if(d.deceasedage < 13, "child", if(d.deceasedage <= 19, "teen", "adult")) as age, count(*)
From bard.accidents a Join bard.deaths d join bard.vessels v on a.bardid = d.bardid = v.bardid
where a.alcoholinvolved = "yes"
and v.vesseltype = "personal watercraft"
and a.numberdeaths > 0
group by year(a.date), age;

select * 
From bard.accidents a join bard.deaths d on a.bardid = d.bardid join bard.vessels v on d.bardid = v.bardid
where a.alcoholinvolved = "yes"
and a.numberdeaths > 0;

select year(a.date) as year, if(d.deceasedage < 13, "child", if(d.deceasedage <= 19, "teen", "adult")) as age, count(*)
From bard.accidents a join bard.deaths d on a.bardid = d.bardid join bard.vessels v on d.bardid = v.bardid
and v.vesseltype = "personal watercraft"
group by year, age;

select d.year, if(d.deceasedage < 13, "child", if(d.deceasedage <= 19, "teen", "adult")) as age, count(*)
From bard.deaths d join bard.vessels v on d.bardid = v.bardid
where v.operatorusingalcohol  = "Y" 
and v.vesseltype = "personal watercraft"
group by d.year, age;

select *
From bard.deaths d join bard.vessels v on d.bardid = v.bardid
where v.operatorusingalcohol  = "Y" 
and v.vesseltype = "personal watercraft";

select vesseltype, count(*)
from bard.vessels
group by vesseltype;

select operatorexperience, count(*)
from bard.vessels
group by operatorexperience;

select *
from bard.vessels
where vesseltype = "personal watercraft"
and operatorusingalcohol = "Y";
#so no other deaths involving alcohol and personal watercrafts? just incidents?

select *
from bard.vessels
where vesseltype = "personal watercraft"
and numberdeaths > 0;
#one result but no alcohol involved