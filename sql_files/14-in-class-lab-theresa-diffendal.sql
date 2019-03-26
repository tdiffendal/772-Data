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
having sum(contribution_amount) > "10000" and avg(contribution_amount) > 250 and contributor_type like '%committee%'
order by sum(contribution_amount) desc;

#Contributor type by candidates
select receiving_committee, contributor_type, SUM(contribution_amount), Count(*) as number_contributions, avg(contribution_amount)
from exercises.md_gov_race
group by receiving_committee, contributor_type
order by receiving_committee, sum(contribution_amount) desc;

#Contributor type totals by candidate with rollup
select receiving_committee, contributor_type, SUM(contribution_amount), Count(*) as number_contributions, avg(contribution_amount)
from exercises.md_gov_race
group by receiving_committee, contributor_type with rollup;

# Overall totals
Select SUM(contribution_amount), count(*) as number_records

#if function - new column classifying size
Select *, contribution_amount,
If(contribution_amount > 5000, "large contribution", "small contribution")
as contribution_size
From exercises.md_gov_race;

#Count amount of small or large contributions
select If(contribution_amount > 5000, "large contribution", "small contribution") as contribution_size,
count(*), sum(contribution_amount)
From exercises.md_gov_race
Group by contribution_size;

#three size categories
select If(contribution_amount > 5000, "large contribution", IF(contribution_amount > 1000, "small contribution", "tiny contribution")) as contribution_size,
count(*), sum(contribution_amount)
From exercises.md_gov_race
Group by contribution_size;