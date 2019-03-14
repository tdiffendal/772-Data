#Theresa Diffendal March 14, 2019
SET SQL_MODE='only_full_group_by';

select * from exercises.md_gov_race;

#summary statistics for contributor type to all candidates
select contributor_type, SUM(contribution_amount), avg(contribution_amount), min(contribution_amount), max(contribution_amount), Count(*) as number_contributions
from exercises.md_gov_race
group by contributor_type
order by sum(contribution_amount) desc;

#look at same table but only 2018
select contributor_type, SUM(contribution_amount), avg(contribution_amount), min(contribution_amount), max(contribution_amount), Count(*) as number_contributions
from exercises.md_gov_race
where year(contribution_date) = "2018"
group by contributor_type
order by sum(contribution_amount) desc;

#same table but sum contribution > 10000 using 'having'
select contributor_type, SUM(contribution_amount), avg(contribution_amount), min(contribution_amount), max(contribution_amount), Count(*) as number_contributions
from exercises.md_gov_race
where year(contribution_date) = "2018"
group by contributor_type
having sum(contribution_amount) > "10000"
order by sum(contribution_amount) desc;

#Summary table but for candidates
select receiving_committee, contributor_type, SUM(contribution_amount), avg(contribution_amount), min(contribution_amount), max(contribution_amount), Count(*) as number_contributions
from exercises.md_gov_race
group by receiving_committee, contributor_type
order by receiving_committee, sum(contribution_amount) desc;

#13 minutes in