# Theresa Diffendal Mysql Homework No. 4 (14-Homework)
SET SQL_MODE='only_full_group_by';

select * from exercises.md_gov_race;

#1. Write a query that returns a table that lists the top 10 zip codes -- no more, no less, exactly 10 -- that gave the most money to Larry Hogan, with three columns -- one for the zip code, one for the state, and one for total dollar value of contributions. Ignore contributions with a null zip code. Where is the top zip code? How many of the top 10 were in Maryland?
select zip_code, state, sum(contribution_amount) 
from exercises.md_gov_race
where receiving_committee like '%Hogan%'
and zip_code is not null
group by zip_code, state
having sum(contribution_amount) > '150000'
order by sum(contribution_amount) desc;

#2. Write a query that returns a table that lists the top 10 zip codes -- no more, no less, exactly 10 -- that gave the most money to Ben Jealous, with three columns -- one for the zip code, one for the state, and one for total dollar value of contributions? Ignore contributions with a null zip code.  Where is the top zip code? How many of the top 10 were in Maryland?
select zip_code, state, sum(contribution_amount) 
from exercises.md_gov_race
where receiving_committee like '%Jealous%'
and zip_code is not null
group by zip_code, state
having sum(contribution_amount) > 24550
order by sum(contribution_amount) desc;

# 3. Write a query that creates a new column that indicates whether a contribution came from "in-state" or "out-of-state".  Then create a single table that calculates summary stats (count, highest and lowest contribution, average contribution, and total sum) for in-state and out-of-state contributions to Hogan and to Jealous.  This table should have seven rows, and include summary stats for all contribtions to Hogan, all contributions to Jealous, and overall totals.
select if(state="MD", "in-state", "out-of-state") as outin, receiving_committee, count(*), max(contribution_amount), min(contribution_amount), avg(contribution_amount), sum(contribution_amount)
from exercises.md_gov_race
group by outin, receiving_committee with rollup; 

#4 Write a query that counts the number of contributions to Larry Hogan in 2017 by date, and return a table that lists days with more than 400.  More than half of them are in the early part of what month? Can you explain why this might be?
select contribution_date, count(*) as number_contributions
from exercises.md_gov_race
where receiving_committee like "%Hogan%"
and year(contribution_date) = 2017
group by contribution_date
having number_contributions > 400
order by contribution_date desc;

#5 Do a similar analysis for Ben Jealous as you did for Hogan in question 4. Can you explain the top two dates on the list?
select contribution_date, count(*) as number_contributions
from exercises.md_gov_race
where receiving_committee like "%Jealous%"
and year(contribution_date) = 2017
group by contribution_date
having number_contributions > 400
order by contribution_date desc;

#6 There are a lot of null values for employer for individual contributions to both candidates.  Do your best to figure out why.  Are there any patterns with certain candidates, certain contribution types? Which of the two candidates is doing a worse job collecting this kind of information?
select receiving_committee, contribution_type, count(*) 
from exercises.md_gov_race
where employer_name is null
and contributor_type = "Individual"
group by receiving_committee, contribution_type;

#7-9 Think of three questions to ask of this data. Write the question, query and answer below.
select filing_period, receiving_committee, count(*), avg(contribution_amount), sum(contribution_amount)
from exercises.md_gov_race
group by filing_period, receiving_committee with rollup;

select filing_period, receiving_committee, count(*), avg(contribution_amount), sum(contribution_amount)
from exercises.md_gov_race
where filing_period like "%2017%" 
or filing_period like "%2018%"
group by filing_period, receiving_committee;

select contributor_type, receiving_committee, count(*), avg(contribution_amount), sum(contribution_amount)
from exercises.md_gov_race
group by contributor_type, receiving_committee;