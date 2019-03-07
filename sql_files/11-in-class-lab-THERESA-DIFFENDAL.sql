# Theresa Diffendal March 5, 2019

SET SQL_MODE = 'only_full_group_by';

#FULL RECORD SET
SELECT * FROM exercises.md_gov_race;

#Totals for all contributions to all candidates: 16,386,619
Select SUM(contribution_amount)
from exercises.md_gov_race;

#Same query but with as formula: 
select SUM(contribution_amount) as Contribution_Total
from exercises.md_gov_race;

#Calculate average: 296.18
select avg(contribution_amount) as Contribution_Average
from exercises.md_gov_race;

#Min: 0
select min(contribution_amount) as Minimum_Contribution
from exercises.md_gov_race;

#Max: 68,133
select max(contribution_amount) as Maximum_Contribution
from exercises.md_gov_race;

#Count records: 55,327 records; if not * and column instead, will find number of non-null entries
Select count(*) as Number_Contributions
from exercises.md_gov_race;

Select count(employer_name) as Number_Contributions
from exercises.md_gov_race;

#Summary Table for contribution amount
Select sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
From exercises.md_gov_race;

#Summary Table just for Larry Hogan: 14,122,795	396.29		1		68133		35638
Select sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
where receiving_committee like "%Larry%";

#New group by statement, summary tables for both candidates
Select receiving_committee, 
sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Group By receiving_committee;

#Can filter with group by using where, summary table for 2018 contributions
Select receiving_committee,
sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Where year(contribution_date) = 2018
Group By receiving_committee;

#sort summary tables
Select receiving_committee,
sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Where year(contribution_date) = 2018
Group By receiving_committee
Order by Average_Contribution desc;

#group by multiple fields
Select receiving_committee,
year(contribution_date) as Contribution_Year,
sum(contribution_amount) as Contribution_Total,
avg(contribution_amount) as Average_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Group By receiving_committee, Contribution_Year
Order by Average_Contribution desc;

#make four queries with select, some summaries, order by, group by one or more fields, where with %

#See what type of contributors both gave the most and had the highest average contribution
#Self Candidate had highest average but only 1 record, anonymous had lowest average and 2 records
Select contributor_type,
avg(contribution_amount) as Average_Contribution,
sum(contribution_amount) as Total_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Group By contributor_type
Order by Average_Contribution desc;

#Want to see how individual contributions differed dpending on zip code
#21401 had the most donations with 864, 11 zip codes had average contribution of $6000 but only one record
Select zip_code,
avg(contribution_amount) as Average_Contribution,
sum(contribution_amount) as Total_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Where contributor_type like "%individual%"
Group By zip_code
Order by Average_Contribution desc;

Select receiving_committee,
name(employer_name) as Employer,
avg(contribution_amount) as Average_Contribution,
sum(contribution_amount) as Total_Contribution,
min(contribution_amount) as Smallest_Contribution,
max(contribution_amount) as Largest_Contribution,
count(*) as Total_Records
from exercises.md_gov_race
Where employer_name like "%university%"
Group By receiving_committee, employer_name
Order by Average_Contribution desc;