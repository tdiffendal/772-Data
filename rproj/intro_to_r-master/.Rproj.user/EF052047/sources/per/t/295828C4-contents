#################################################################
############# Introduction to Data Analysis in R ################
#################################################################

###################
#### About R ######
###################

# R is a programming language that is especially helpful for data programming, used by data journalists and data scientists around the world. The huge community of users is generally friendly, willing to help beginners and great about creating learning materials.
# Learn more: https://www.r-project.org/
# Download R: https://cran.r-project.org/bin/macosx/

###################
## About RStudio ##
###################

# RStudio is an integrated development environment -- similar to MySQL Workbench -- that is designed to help you do data analysis. 
# Learn more: https://www.rstudio.com/products/RStudio/
# Download RStudio: https://www.rstudio.com/products/rstudio/download/#download
# Cheatsheet: https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf

####################
# About R Packages #
####################

# R packages are pre-written bundles of code that provide shortcuts to help you do all kind of different and specific things in the data programming universe -- visualize data, clean data, pull data from Twitter, scrape websites, and a whole lot more. There are THOUSANDS of free packages available for your use.
# All packages: https://cran.r-project.org/
# Some greatest hits: https://awesome-r.com/

#######################
# About The Tidyverse #
#######################

# One particularly useful collection of packages is called The Tidyverse, a collection of related packages that make doing data cleaning, data wrangling, data analysis and data visualization easier. This tutorial makes use of several Tidyverse packages to load, wrangle and analyze data. You can do everything we're doing with the base R language, but it's more of a slog.  My recommendation: if you're using R, use Tidyverse methods instead of base R whenever possible.   
# Site: https://www.tidyverse.org/
# Cheatsheets: https://www.rstudio.com/resources/cheatsheets/
# List of Tidvyerse packages: https://www.tidyverse.org/packages/
# Canonical Book: https://r4ds.had.co.nz/index.html
# Tutorials: https://rstudio.cloud/learn/primers/
# Online Courses: I used to recommend DataCamp, but I can no longer do so.  Looking for good replacements now. 


##########################
## Create an R Project ###
##########################

# It's a good idea to create a new "R Project" file (.Rproj) for each analysis project. Among other things, doing so gives you a folder to store everything in -- data and script files -- and it sets your "working directory" to make it easy to load data.      

# To create a new R Project: Go to Top Menu > File > New File > New Project to create. 

##########################
## Create a Script File ##
##########################

# You can execute R code directly in the console.  But it's a MUCH better idea to write out your scripts in a file (in R, script files end in .r) like this one, and execute them so they run in the console.       

# To create a new script file: Menu > File > New File > R Script.  Name it script.r.  

##########################
#### Install Packages ####
##########################

# The first time you are setting up a new machine, you'll need to install a package.  Once it's on the machine, you don't have to load it again.

# The code below will install all of the packages of the tidyverse. Highlight it and hit the "Run" button above. Notice it executes in the console below.    

install.packages('tidyverse')

##########################
##### Load Packages ######
##########################

# At the start of every session, you must load the packages you want to work with.

library(tidyverse)

##########################
##### Read in Data #######
##########################

# To read in data, we're using a function from the Tidyverse package called readr.
# For more advanced tips information, see:  https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf

# The code below reads in a csv of campaign contributions in the 2018 Maryland governor's race and stores it as an object called md_election. For full documentation, visit: https://github.com/smussenden/data-journalism-19-spring/blob/master/sessions/14/14-In-Class-Lab/14-SQL-Lab-4.md

md_election <- read_csv("md_election.csv")

# Look at the "environment" window at the right.  It shows an object called md_election with 55327 rows (in R, rows are called obs. or observations) and 13 columns (in R, called variables). 

# Look at the console below.  It notes the columns it read in and what encoding it assigned.  It also noted warnings for problems loading in the data.    

##########################
##### Examine Data #######
##########################

# As we go through this section, where applicable I will display the equivalent SQL code. 

# This functions displays the data as a sortable spreadsheet. 

View(md_election)

# SQL Equivalent # 
# SELECT *
# FROM md_election;


##########################
## Get a Sense of Data ###
##########################

# These two functions will give you a sense of what columns are in the data, the column data type and values. They output in the console.

summary(md_election)

glimpse(md_election)

View(head(md_election))

##############################
# Transform and Analyze Data #
##############################

# The tidyverse provides excellent methods for transforming and analyzing data.
# Cheatsheet: # https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf

##############################
##### Selecting Columns ######
##############################

##### Select only certain columns #####  
# Note that we're saving this as a new object called md_election_working.  It pops up as a new object at right.
# The first "argument" of the select function is the name of the spreadsheet -- or dataframe in R parlance -- md_election. This is common with tidyverse functions.  The other three are columns.   

md_election_working <- select(md_election, receiving_committee, contributor_name, contribution_amount)

View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election;

##### Select everything except certain columns ##### 

md_election_working <- select(md_election, -receiving_committee)
View(md_election_working)

##############################
### Introduction to Pipes ####
##############################

# Pipes (%>%) are a big part of the tidyverse, and provide a better way to write functions. 
# Think of them as standing in for the words, "and then".
# Using them lets us store the name of the dataframe at the top of the function, so we don't have to write it again.  This is especially useful when we start chaining commands together. 
# This says "take the dataframe called md_election AND THEN select every column except receiving_committee. 
# Notice that we don't need to put the name of the dataframe as the first argument in the select function.

md_election_working <- md_election %>%
  select(-receiving_committee)
View(md_election_working)

##############################
######### Sorting ############
##############################

##### Sort a column from lowest to highest value #####
md_election_working <- md_election %>%
  arrange(contribution_amount)
View(md_election_working)

# SQL Equivalent # 
# SELECT *
# FROM md_election
# ORDER BY contribution_amount;

##### Sort a column from highest to lowest value #####
md_election_working <- md_election %>%
  arrange(desc(contribution_amount))
View(md_election_working)

# SQL Equivalent # 
# SELECT *
# FROM md_election
# ORDER BY contribution_amount desc;

##############################
##### Chaining with Pipes ####
##############################

# Just like with SQL, we can chain different types of functions together using %>%

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# ORDER BY contribution_amount desc;


##############################
######### Filtering ##########
##############################

##### Filtering by one value as an exact match #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(receiving_committee == "Hogan Larry for Governor")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE receiving_committee = "Hogan Larry for Governor"
# ORDER BY contribution_amount desc;

##### Filtering by one number #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_amount > 10000)
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_amount > 10000
# ORDER BY contribution_amount desc;

##### Filtering by two values (AND) #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_amount > 10000, receiving_committee == "Hogan Larry for Governor")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_amount > 10000 AND receiving_committee = "Hogan Larry for Governor"
# ORDER BY contribution_amount desc;

##### Filtering by one value OR another #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(state == "VA" | state == "MD")
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE state == "VA" OR state == "MD"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text in any part of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "Republican"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "%Republican%"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text at start of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "^Republican"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, state, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "Republican%"
# ORDER BY contribution_amount desc;

##### Filtering with wildcards - text at end of field #####

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(str_detect(contributor_name, "Maryland$"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contributor_name, contribution_amount
# FROM md_election
# WHERE contributor_name LIKE "%Maryland"
# ORDER BY contribution_amount desc;

##### Filtering with dates #####

# To make it easier to work with dates, we need to install a new package, lubridate, which has a lot of built in functions to work with dates. 
# Lubridate is a package that is part of the tidyverse family, but it doesn't automatically load when we load the rest of the tidyverse. So we have to load it separately.  We only need to install it once. 

install.packages('lubridate')

# Now load it.  Typically, we'd put this at the top of our script file when we load the rest of the packages.

library('lubridate')

##### Filter based on specific date ##### 

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_date > as_date("2017-12-31"))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, contribution_date, contributor_name, contribution_amount
# FROM md_election
# WHERE contribution_date > "2017-12-31"
# ORDER BY contribution_amount desc;

##### Filter based on year ##### 

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(year(contribution_date) == 2017)
View(md_election_working) 

# SQL Equivalent # 
# SELECT receiving_committee, contribution_date, contributor_name, contribution_amount
# FROM md_election
# WHERE YEAR(contribution_date) = 2017
# ORDER BY contribution_amount desc;

##############################
##### Adding New Columns #####
##############################

#### Add a column with a unique identifier ####
md_election_working <- md_election %>%
  mutate(record_number = row_number())
View(md_election_working) 

#### Add a new column based on another column ####
md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date))
View(md_election_working) 

# SQL Equivalent # 
# SELECT *, YEAR(contribution_date) as contribution_year
# FROM md_election;

#### Add several new columns based on another column ####

md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date),
         contribution_month = month(contribution_date))
View(md_election_working) 

# SQL Equivalent # 
# SELECT *, YEAR(contribution_date) as contribution_year, MONTH(contribution_date) as month
# FROM md_election;

#### Using If Else to create new columns ####

md_election_working <- md_election %>%
  mutate(contribution_size = if_else(contribution_amount > 10000, "large_contribution", "small_contribution"))

# SQL Equivalent # 
# SELECT *, contribution_amount, IF(contribution_amount > 10000, "large contribution", "small contribution") as contribution_size
# FROM md_election;

#### Create new columns with a different version of nested If Else statements ####

md_election_working <- md_election %>%
  mutate(contribution_size = case_when(
    contribution_amount > 20000 ~ "very large",
    contribution_amount > 10000 ~ "large",
    contribution_amount > 1000 ~ "medium",
    contribution_amount > 0 ~ "small"))           
View(md_election_working)           
   
#### Create new columns based on math ####

md_election_working <- md_election %>%
  mutate(contribution_times_10 = contribution_amount*10)
View(md_election_working)

# SQL Equivalent # 
# SELECT *, (contribution_amount*10) as contribution_times_10
# FROM md_election;


##############################
# Calculating Summary Stats ##
##############################

#### Grouping by a column and counting ####
md_election_working <- md_election %>%
  group_by(receiving_committee) %>%
  summarise(number_records = n()) %>%
  arrange(desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, count(*) as number_records
# FROM md_election
# GROUP BY receiving_committee
# ORDER BY number_records desc;

#### Grouping by two columns and counting ####

md_election_working <- md_election %>%
  group_by(receiving_committee, state) %>%
  summarise(number_records = n()) %>%
  arrange(receiving_committee, desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, state, count(*) as number_records
# FROM md_election
# GROUP BY receiving_committee, state
# ORDER BY receiving_committee, number_records desc;


#### Creating a summary table with sum, mean, median, min and max ####
md_election_working <- md_election %>%
  group_by(receiving_committee) %>%
  summarise(number_records = n(),
            contribution_total = sum(contribution_amount),
            average_contribution = mean(contribution_amount),
            median_contribution = median(contribution_amount),
            minimum_contribution = min(contribution_amount),
            maximum_contribution = max(contribution_amount)
            ) %>%
  arrange(receiving_committee, desc(number_records))
View(md_election_working)

# SQL Equivalent # 
# SELECT receiving_committee, count(*) as number_records, SUM(contribution_amount) as contribution_total, AVG(contribution_amount) as average_contribution, min(contribution_amount) as minimum_contribution, max(contribution_amount) as maximum_contribution
# FROM md_election
# GROUP BY receiving_committee
# ORDER BY receiving_committee, number_records desc;

##############################
### ON YOUR OWN EXERCISES ####
##############################

# Okay, your turn.  Come up with five new questions to ask based on the methods described above and ask them.  Put the questions and answers in comments

# When you're finished, upload this script file to ELMS.

##############################
### START DAY 2 ##############
##############################


##############################
########### Joins ############
##############################

# Just as in SQL, it's easy to join together two data sets in R, especially using Tidyverse's Dplyr package functions. You'll find all of the standard SQL join types (left, right, inner, full outer).  Plus there are a few more that come in handy. 

rm(list=ls())

# We're going to work with our campaign data again, so read that in. 

md_election <- read_csv("md_election.csv")
View(md_election)

# In our data, we just have a two character field for state, instead of the full name.  So, we're going to read in a csv with state name and code information. This is essentially a lookup table. 

state_lookup <- read_csv("states.csv")
View(state_lookup)

# To make it easy to examine the different kinds of joins in R, and how they work, let's create a dataframe only with the state abbreviations in our contribution data, grouped by abbreviation. 

md_election_states <- md_election %>%
  select(state) %>%
  group_by(state) %>%
  summarise(count = n()) %>%
  arrange(desc(state))
View(md_election_states)

# Note that our contribution data (md_election_states) has 57 unique values for states.  Our state_lookup only has 51.  So when we join, we'll see some unique behavior. 

###### Inner Join ######
# Keep all records where there is an identical values in BOTH tables we're joining. 
# Note that we're using Pipes %>% here.  We put one dataframe name (md_election_states) at the top of the function, and the other (state_lookup) inside the inner_join function.
# "by" is an argument in which we specify which columns to join. The name of the field in our contribution data (md_election_states) is "state". In our lookup table (state_lookup), it's called abbreviation. 

states_join_inner <- md_election_states %>%
  inner_join(state_lookup, by=c("state" = "Abbreviation"))
View(states_join_inner)

# This returns 51 observations, which happens to be the same number in our lookup table. Our md_election_states had 57 observations, meaning some have been elimiated because they didn't have a match in our lookup table. 

###### Left Join ######
# Keep all values from our contributions table (md_election_states, named at the top of the function) and only include values from our lookup table (state_lookup, named inside the left_join() function) if they also exist inside our contribution table.  

states_join_left <- md_election_states %>%
  left_join(state_lookup, by=c("state" = "Abbreviation"))
View(states_join_left)

# 57 records, six of which are in md_election_states but not in state_lookup

###### Right Join ######
# Keep all values from our lookup table (state_lookup, named inside the right_join() function) and only include values from our contributions table (md_election_states, named at the top of the function)if they also exist inside our lookup table.  
states_join_right <- md_election_states %>%
  right_join(state_lookup, by=c("state" = "Abbreviation"))
View(states_join_right)

# 51 records.

###### Full Outer Join ######
# Keep all values from both tables, and connect them where there's a match

states_join_full <- md_election_states %>%
  full_join(state_lookup, by=c("state" = "Abbreviation"))
View(states_join_full)

# 57 records. 

###### Anti-Join ######
# This is a new one, and it's handy because it lets us see ONLY those values that DO exist in one table, but not the other.  It's kind of the opposite of an inner join. 

states_anti_join <- md_election_states %>%
  anti_join(state_lookup, by=c("state" = "Abbreviation"))
View(states_anti_join)

# This returns six records, and they're all state codes that aren't in our lookup_table, VI is the virgin islands, PR is puerto rico, NULL is missing values, Md is obviously an error that should be corrected (MD), GU is Guam, and AE is an overseas postal code often used by members of the military.  

##############################
## Working with Strings ######
##############################

# The stringr package has several functions that make it easy to work with text "strings". 
# https://github.com/rstudio/cheatsheets/raw/master/strings.pdf
# https://stringr.tidyverse.org/index.html

# Identify something inside of a text field with string detect str_detect(). This returns all records that contain the word Republican anywhere in the contributor_name field. 

md_election_working <- md_election %>%
  filter(str_detect(contributor_name, "Republican"))
  
# Mash up two strings together to create a new string with str_c(), similar to CONCATENATE in Excel. This uses mutate to create a brand new column called name_occupation that puts together the contents of the employer_occupation field and the employer_name field, with a dash separating them.

md_election_working <- md_election %>%
  mutate(name_occupation = str_c(employer_occupation, "-", employer_name))

# Replace a value in a string.  This creates a new column called contributor_name_fixed from the original contributor_name, and replaces every instance of the word "Republican" with the word "GOP". To make it easy to see the change, it uses str_detect to filter out the rows that now have GOP in it.  Compare the contributor_name_fixed to contributor_name.  

md_election_working <- md_election %>%
  mutate(contributor_name_fixed = str_replace(contributor_name, "Republican", "GOP")) %>%
  filter(str_detect(contributor_name_fixed, "GOP"))

# Trim whitespace from the beginning and end of a string with str_trim.  This is a common data cleaning problem that prevents grouping from happening properly. 

md_election_working <- md_election %>%
  mutate(cleaned_contributor_name = str_trim(contributor_name))

# To convert strings to upper or lower case, use str_to_upper or str_to_lower.  When we were doing joins, we saw that most records used "MD" for state, but some used "Md".  We can fix this with str_to_upper. 

md_election_working <- md_election %>%
  mutate(cleaned_state = str_to_upper(state))

##############################
## Write out Data ############
##############################

# To write data out to share or use in another program, the readr package has a great package of functions. 
# https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf
# https://readr.tidyverse.org/

# This function will write our md_election_working dataframe to a csv called "md_election_working.csv"

write_csv(md_election_working, "md_election_working.csv")

##############################
## Working with Functions ####
##############################

# Functions are a powerful tool that allow us to be more efficient in our data programming. 
# Functions are a recipe, a piece of code that takes a piece of data (called arguments) that you give it, does something to, then produces an output.  
# You've used a lot of prebuilt functions already.  sum() is a function that adds up numbers you give it.  select() is a function that lets you return certain fields from a dataframe. read_csv() lets you read in data.  
# But sometimes we want to write our OWN functions that aren't already included with other packages. 

### A simple example to get us started.###
### This code "defines a function called "print_name".  When we execute the function later, we'll feed it a name, and it will execute the code to print it out in the console. 
#### When you run the code below, notice it appears under "functions" in the environment window at right. 

print_name <- function(name) {
  print(name)
}

### Now execute the function. The name I'm going to feed it is "sean" in quotes. Notice how it prints out in the console. 
print_name("sean")

### Try printing your name now. 

print_name("your_name")

### That wasn't that useful.  So now let's create a function for a task we do over and over again -- group and count values in a column to get a sense of the data. 

# First step, build a sample of the thing we want to functionize.  This code creates a dataframe called md_election_working that groups by the values in the filing period column and counts them, then sorts by count, then pops up that dataframe for us to view. 

md_election_working <- md_election %>%
  group_by(filing_period) %>%
  summarise(count=n()) %>%
  arrange(desc(count))
View(md_election_working)

### We could copy and paste this over and over again and changed the column named in the group_by section of the code. Or we could functionize it! 

### Let's create a function called column_check that will allow us to feed in the name of a column and automatically let us view a group_by, counted and sorted dataframe of that column. Notice that I'm taking the function above and dropping it inside a newly created function called column_check.
### In the example below, columnname is the argument we'll feed to the function. 
### In the code, instead of group_by identifying a specific column, it's the more generic "columnname", which is what we'll be feeding into the function each time we execute it. 
### Run the code below, and notice that column_check pops up at right in the environment.  

column_check <- function(columnname){
  md_election_working <- md_election %>%
    group_by(columnname) %>%
    summarise(count=n()) %>%
    arrange(desc(count))
  View(md_election_working)
}

### Now let's execute the function by feeding it the name of the receiving_committee column
column_check(filing_period)

### We get an error in the console.  Why?  R is having a hard time passing the name of our column to the function.  We need to help it. 
### Let's modify our function slightly to wrap columnname in the group_by function with another function, group_by(!!enquo(columnname)).  This will make sure it passes correctly.
### Run the code below to redefine the function. 
column_check <- function(columnname){
  md_election_working <- md_election %>%
    group_by(!!enquo(columnname)) %>%
    summarise(count=n()) %>%
    arrange(desc(count))
  View(md_election_working)
}

### Now execute it again. 
column_check(filing_period)

### It works. Test it out by trying another column. 
column_check(receiving_committee)

##############################
## On Your Own ###############
##############################

# Write at least three functions that you think would be useful for processing data -- something repeatable you'd do over and over again.  Try to incorporate string manipulation in at least one function. 

# Then, go out and find at least ONE brand new to you R package -- it could be part of the tidyverse, could not be.  Load it in and attempt to use at LEAST one of the functions it provides.  You'll need to read the documentation, search stack overflow, look at cheatsheets. 
# Some greatest hits: https://awesome-r.com/
# All packages: https://cran.r-project.org/

### Upload to ELMS.
