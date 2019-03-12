/* Mysql Assignment No. 2 (11-SQL Assignment 2)*/
/* Connect to JOURDATA in MySQL Workbench, Then open this file in MySQL Workbench. Rename it Firstname-Lastname-11-SQL-Assignment-2.sql. Work in this file to answer the questions. */
/* Underneath each question below, create a new comment with the correct answer.  Underneath the answer -- NOT in a comment -- put the SQL query you used to derive the answer.*/
/* Use the deer table in the exercises database.  This is a single-table database of hunting accidents in Wisconsin in 1993.*/
/*Execute this function first: SET SQL_MODE='only_full_group_by';*/
/* Use this documentation */
/* CASE - case number
DATE - date of accident
TIME - time of accident
COUNTY - Wisconsin county
AREA - region of state
WOUND - body part of shooting
INJURY - minor, major or fatal
TYPE - si (self-inflicted wound) or sp (person in same party)
CAUSE - description of cause of accident
SAGE - shooter age
VAGE - victim age
FIREARM - firearm type (shotgun, rifle, pistol, etc)
FACTION - firearm action type (slide, auto, bolt, lever, etc...)
ALCOHOL - was alcohol involved in accident
ALCOLEV - if alcohol invoved, what was bac
WEATHER - weather conditions
TOPOGRO - terrain type (rolling, level, steep, etc...)
SEXPER - shooter years of expereince
VEXPER - victim years of experience
SGRADUATE - shooter graduate of hunting safety course
VGRADUATE - victim graduate of hunting safety course
SSEX - shooter gender
VSEX - victim gender
GUNBRND - brand of gun
GUNGUAGE - gauge of gun
TEMP - outside temperature
MUZDIS - distance from shooter to victim in feet
LAND - ownership of land (private, public, etc...)
VORANGE - number of article of clothing that are orange worn by victim
GUNSIGHT - gun sight type
VACTIVTY - victim activity at time of shooting
LOCATION - location type of shoting
PRECIP - preciptating or not */
/*Submit to ELMS https://umd.instructure.com/courses/1259604/assignments/4811988 */

SET SQL_MODE='only_full_group_by';
Select * from exercises.deer;

# 1.  Using the WOUND field, do a summary query that shows the number of times each body part was the site of a wound in this table, ordered from most common to least common. What was the most common body part to be injured? How many different body parts were listed in the wound column?
#Leg was most common with 41 incidents; 24 total body parts listed
Select wound,
count(wound) as Number_Incidents
from exercises.deer
Group by wound
Order by Number_Incidents desc;

# 2. Write a query that returns a table that shows all the cases where someone was injured at their ankle -- or below -- ordered alphabetically by wound type.  Hint: do not include injuries categorized as "leg" in this total.  How many such cases were there?
#46 cases
Select wound,
Count(wound) as Number_Incidents
from exercises.deer
Where wound IN ('foot', 'toe', 'ankle')
Group by wound
Order by wound asc;

# 3. Write a query that shows all records for self-inflicted accidents by shooters who are 50 years old or older, ordered by shooter age from oldest to youngest.  How many are there?
#9 incidents across 7 ages, from 50-66
Select SAGE, count(type) as Number_Incidents
from exercises.deer
where type = "si"
AND sage >= "50"
Group by sage
Order by SAGE desc;

# 4. Write a query that allows you to easily determine the oldest victim in Jackson County? Describe the incident in as much detail as possible from the records.
#On Nov. 11, 1987 at 3 p.m., an 18 year old woman with 1 year of experience and no hunting safety course experiecnce fired a 20 gauge shotgun that hit a 62 year old man, who was in the shooter's party, in the thigh, leaving a minor wound. It was a cloudy, 34 degree day and the victim was standing over 1000 feet from and standing out of sight of the shooter.
Select * from exercises.deer
Where county = "Jackson"
Order by VAGE desc;

# 5. Which county had the most accidents? How many? 
#Marathon with 9 incidents
Select county,
count(county) as Number_Incidents
From exercises.deer
Group by county
Order by Number_Incidents desc;

# 6. What was the most frequent cause of hunting accidents listed in the database? How many accidents appear with that cause?
#Victim in line of fire was most common with 48 incidents
Select cause,
count(cause) as Number_Incidents
From exercises.deer
Group by cause
Order by Number_Incidents desc;

# 7.  Write a query that gives you a count of accidents for each brand of gun, ordered from most to least.
Select GUNBRND,
count(GUNBRND) as Number_Incidents
From exercises.deer
Group by GUNBRND
Order by Number_Incidents desc;

# 7A.  In this table, which brand of gun is involved in the most hunting accidents? How many accidents are there with that brand? Does that make it the most dangerous brand? Explain why or why not.
#Remington brands were involved in 79 accidents; it is not necessarily the most dangerous brand, though it could be, but it could also be the most common; also we'd have to define "danger" here: did it result in the most deaths?
# 7B. Would you feel comfortable listing the number of accidents for Winchester as 39? How about Ithaca as 6?  Or Coast to Cost as 2? Explain your reasoning for each.
#I might feel comfortable listing Winchester with 39 incidents, but Coast to Cost appears twice on the table with different spellings. There are a few other instances of misspellings (Ithica and Ithaca, Thompson and Thompson Cent), which could be enough to make me unsure of the Winchester data.

# 8. What is the average age of shooters? What is the average age of victims? Write one query to build a summary table that determines both. Do you see any issues with the data that would lead you to doubt these conclusions? Include the queries you used to determine these issues.
#AvgSAGE: 28.23 AvgVAGE 30.88; I'm not sure if the shooter and victim being the same person in si types matters; there are also a few nulls in SAGE
Select avg(SAGE) as Average_Shooter_Age,
avg(VAGE) as Average_Victim_Age
from exercises.deer;

# 9. What has a higher average age – the shooters in cases with minor, major or fatal injuries (coded in the INJURY field)?
#Fatal has the highest average shooter age
Select INJURY,
avg(SAGE) as average_shooter_age
From exercises.deer
Group by Injury;

# 10.  Did more accidents occur on days with bad weather than days clear skies? Is that enough to say whether weather is a factor in accidents? Why?
#125 incidents on clear days, 128 on cloudy, partyly cloud or unknown days; the numbers are too close to determine if one is a significant factor, and may indicate weather isn't a factor
select weather,
count(weather) as number_incidents
from exercises.deer
Group by weather;

# 11. What was the most common wound in fatal accidents?
#Chest, with 12 incidents (head is close second with 11)
Select wound,
count(wound) as number_incidents
from exercises.deer
where injury = "fatal"
Group by wound
Order by number_incidents desc;

Select * from exercises.deer;

# 12. Were most fatal wounds inflicted by the shooter or a second person? How useful are the answers you get?
#Most fatal wounds were inflicted on a second person by the shooter; there were 27 fatal incidents but only 21 listed in my results; it did not count the null incidents, which accounted for more than the si, meaning the data is missing a large component
Select type,
count(type) as number_incidents
from exercises.deer
where injury = "fatal" 
Group by type
Order by number_incidents desc;

select * from exercises.deer;
where injury = "fatal";

# 13. Do a count of accidents by date. Do you see any patterns suggestive of a story?
#Seem to be increased accidents in week leading up to Thanksgiving; turkey hunting gone awry?
Select date,
count(date) as number_incidents
from exercises.deer
Group by date;

