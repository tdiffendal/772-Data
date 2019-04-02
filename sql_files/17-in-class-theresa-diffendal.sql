#Theresa Diffendal, session 17 in-class
 
SET SQL_MODE='only_full_group_by';

select * from fars.accident;

select year, count(*)
from fars.accident
group by year;

#Lookup table
select *
from fars.lkp_day_of_week;

select *
from fars.lkp_state;