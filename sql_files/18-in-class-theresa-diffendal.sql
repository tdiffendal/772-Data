#Theresa Diffendal. session 18 in-class

SET SQL_MODE='only_full_group_by';

select * from fars.accident;
select * from fars.lkp_state;

select *
from fars.accident a
join fars.lkp_state b on a.state=b.code;

select * from fars.lkp_harmevent;

select *
from fars.accident a
join fars.lkp_state b on a.state=b.code
join fars.lkp_harmevent c on a.harm_ev=c.code;

use fars;

create temporary table accident_100
select * from fars.accident
limit 100;

select * from accident_100;

select b.event_desc, b.code, count(*)
from fars.accident a
join fars.lkp_harmevent b on a.harm_ev=b.code
group by b.event_desc, b.code
order by count(*) desc;

select b.event_desc, b.code, count(*)
from fars.accident a
join fars.lkp_harmevent b on a.harm_ev=b.code
group by b.event_desc, b.code
having count(*) > 100
order by count(*) desc;

create temporary table common_harm_effects
select b.event_desc, b.code, count(*)
from fars.accident a
join fars.lkp_harmevent b on a.harm_ev=b.code
group by b.event_desc, b.code
having count(*) > 100
order by count(*) desc;

select * from common_harm_effects;

select * 
from fars.accident a
join common_harm_effects b on a.harm_ev=b.code;

