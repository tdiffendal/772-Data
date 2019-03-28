#Theresa Diffendal Exam 2

SET SQL_MODE='only_full_group_by';

#Part 1 (8 questions, 5 points each, 40 points) + 5 points extra credit
#You are a reporter at the Washington Post, and your editor has assigned you to report a story about the role outside groups -- like PACs (Political Action Committees) -- played in the 2016 election through independent expenditures. You obtain from the Federal Election Commission a dataset detailing spending by these groups. It is called outside1, in the exercises database.

select * from exercises.outside1;

#From the FEC: "An independent expenditure is an expenditure for a communication that expressly advocates the election or defeat of a clearly identified candidate and which is not made in coordination with any candidate or his or her campaign or political party. 100.16, 109.21 and 109.37. Independent expenditures are not subject to any limits but may be subject to reporting requirements."

/*date - date reported
cand_name - name of candidate involved
spender_id - Alphanumeric id of spender (PAC, other outside group)
spender_nam -Name of spender (PAC, other outside group)
district_state - location of election to be affected by expenditure (blank, 00, US, DC mean national spending)
cand_party - party of candidate affected
expend_amt - amount of expenditure
expend_date - date of expenditure
sup_opp - designates whether spending was in support or opposition to candidate
purpose - purpose of spending
tra_id - FEC report that included this expenditure*/

#How many of the expenditures in the table are in support of a candidate, and how many were in opposition to a candidate? How much money in total was in support of a candidate and how much money in total was in opposition? Write a single query that gives you all four answers. Paste it, and the answers below. Ignore null values.
#Oppose sum $313,383,967.09     count 29983
#Support sum $146,584,013.92     count 40108

select sup_opp, sum(expend_amt), count(*)
from exercises.outside1
group by sup_opp;

#What candidate had the most money spent against them? What candidate had the most money spent supporting them? Ignore null values.
#Donald Trump had the most money spent both in support ($98,871,957) and in opposition ($206,585,465.82)

select sup_opp, cand_name, sum(expend_amt)
from exercises.outside1
group by sup_opp, cand_name
order by sum(expend_amt) desc;

#In what month of what year was the most money spent? How much was spent in that month? Use the date field, not expend_date.
#The most money ($158,306,430.31) was spent in October, 2016, the month before the election
select year(date), month(date), sum(expend_amt)
from exercises.outside1
group by year(date), month(date)
order by sum(expend_amt) desc;

#In the month/year combo identified in question 3, how much was spent in support and how much was spent in opposition? Use the date field, not expend_date.
#Oppose: $117,704,223.95
#Support: $40,592,597.36
select sup_opp, sum(expend_amt)
from exercises.outside1
where year(date) = "2016" and month(date) = "10"
group by sup_opp;

#The district_state field shows the location where the spending was intended to influence voters. If the field is blank, or 00 or US or DC, then it is national-level spending. Other values pertain to specific states. Create a new column that combines the blank, 00, US and DC values into ‘national’ and leaves the rest of the state values unchanged, then shows the total spending opposed to Hillary Clinton. What individual state had the most money spent opposed to Clinton? How much was it?
#Kentucky with $791,151.46 against Clinton; for if true "national-level" value, opposed amount is $102,165,934.66
select if(district_state = "US" or district_state = "00" or district_state = "DC" or district_state is null, "national-level", district_state) as location, sum(expend_amt)
from exercises.outside1
where cand_name like "%Clinton%"
and sup_opp = "oppose"
group by location
order by sum(expend_amt) desc;

#How many different values for purpose are listed in the table? If you wanted to draw conclusions about the purpose of the money outside groups are spending, why would that be challenging?
#1832 different values, but only 81 values were listed as the purpose at least 20 times, only 40 values for 50 counts, and only 16 with counts over 100; this indicates a lack of clear values for the purpose column, allowing for different rows for "canvassing", "canvassing services", "canvass expense" as well as very specific purposes, such as "tv ds - fox news" or the "vote for hillary clinton" values; some conclusions could be drawn since the count of the top purposes are so high, but over 1700 purposes would be lost if you wanted to search for only significant ones, such as with counts over 20
select purpose, count(*)
from exercises.outside1
group by purpose
order by count(*) desc;

#How much was total money was spent in support and in opposition by the committee with ‘Priorities’ in its name? Use a rollup query to show the support and oppose amount for that committee and overall total of spending for that committee. Below, List the name of the committee, the support and oppose amount and overall total for that committee.
#Priorities USA Action: oppose $125,146,391.61, support $450,000, total $125,596,391.61
select spender_nam, sup_opp, sum(expend_amt)
from exercises.outside1
where spender_nam like "%Priorities%"
group by spender_nam, sup_opp with rollup;

#In spending for which the purpose included the name of a social network (for example, Facebook, YouTube, Snapchat, Instagram) or the word "social", which candidate had the most spent in support and which candidate had the most total expenditures spent in opposition? How much was it?
#$1,000,000 in support of William Bill Weld, Gary Johnson /
#$682,400 in opposition to Clinton, Hillary
select cand_name, sup_opp, sum(expend_amt)
from exercises.outside1
where (purpose like "%facebook%"
or purpose like "%youtube%"
or purpose like "%twitter%"
or purpose like "%social%")
group by cand_name, sup_opp
order by sum(expend_amt) desc;

#EXTRA CREDIT. Create a new column to lump together all spending in favor of Trump or opposed to Clinton as “for Trump.” Lump together all spending in favor of Clinton or opposed to Trump as “for Clinton.” Categorize any other spending as “other.” List the total for the three groups. Which is greater, spending "for Clinton" or "for Trump?"
#' for Clinton' = $250,312,813.06	'for Trump' = $205,245,220.63	'other' = $4,433,817.47 	so for Clinton is greater
select 
if(sup_opp like "%support%" and cand_name like "%Trump%" or sup_opp like "%oppose%" and cand_name like "%Clinton%", "for Trump", if(sup_opp like "%support%" and cand_name like "%Clinton%" or sup_opp like "%oppose%" and cand_name like "%Trump%", "for Clinton", "other")) as candidate, sum(expend_amt)
from exercises.outside1
group by candidate
order by sum(expend_amt);

#Part 2 (40 points, 5 points each)
#You are a reporter at the Baltimore Sun and your editor has assigned you to report a story about the role people in Maryland played funding the 2016 presidential election. The table md_contrib lists campaign contributions for president from individuals in Maryland during the election. The table md_cand lists information about each candidate. The tables join on the ‘cmte_id’ field. The documentation is at the end of this test. You MUST do a join in every query.

select * 
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id;

select * from exercises.md_contrib;
select * from exercises.md_cand;

/*Candidate - md_cand
CAND_NAME - 2016 presidential candidate name
party - candidate party affiliation
cmte_id - candidate campaign committee ID
city - candidate city
state - candidate state
zip - candidate zip or zip+4
Contributions - md_contrib
CMTE_ID - candidate campaign committee ID
RPT_TP - reporting period
NAME - contributor name
CITY - contributor city
STATE - contributor state
ZIP_CODE - contributor zip code
EMPLOYER - contributor employer
OCCUPATION - contributor occupation
amount - contributor amount
MEMO_TEXT - notes about contribution
date - date of contribution*/

#Which candidate got a contribution from a donor who listed their occupation as a the owner of a food truck?
#Hillary Clinton
select *
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where occupation like "%truck%";

#What city in Maryland contributed the most money to Donald Trump? How much?
# Bethesda gave $4,950 to Trump
select t.city, sum(t.amount)
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where t.state = "MD"
and d.cand_name like "%Trump%"
group by t.city
order by sum(t.amount) desc;

#How many contributions were given to Hillary Clinton by people who had the word attorney or lawyer included in their occupation? Don't include abbreviations of these words in the count of contributions.
# 506 contributions by lawyers or attorneys to HC
select *
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where (t.occupation like "%attorney%" or t.occupation like "%lawyer%")
and d.cand_name like "%Clinton%"
order by t.occupation;

select *
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where d.cand_name like "%Clinton%"
and t.occupation like "%attorney%" or t.occupation like "%lawyer%";

select t.occupation, count(*)
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where d.cand_name like "%Clinton%"
group by t.occupation;

#Which candidate got the second most money from people who had the word attorney or lawyer included in their contribution. Don't include abbreviations of these words in the count. How much did they get?
#O'Malley received the second highest amout of donations from attorneys or lawyers with $191,990
select d.cand_name, sum(t.amount)
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where (t.occupation like "%attorney%" or t.occupation like "%lawyer%")
group by d.cand_name
order by sum(t.amount) desc;

#How many donors gave a combined total of $20,000 or more to all of the Republican presidential candidates? Write a single query that returns a table with only those donors and no other donors.
select t.name
from exercises.md_contrib t join exercises.md_cand d on t.cmte_id=d.cmte_id
where d.party = "REP";

#Contributions for a negative amount represent refunds or "redesignations" of the contribution to another contributor (i.e. re-assigning the contribution to a spouse, so you can give more money). How many such contributions are in the data for Ted Cruz?

#Which two presidential candidates received the most money from contributors in Maryland? Write a single query that returns the total amount of money contributed for only those two candidates.

#If you remove contributions of 0 or less, how many candidates have an average contribution amount less than Bernard Sanders?