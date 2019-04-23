install.packages('tidyverse')
library(tidyverse)

md_election <- read_csv("md_election.csv")
view(md_election)
summary(md_election)
glimpse(md_election)
view(head(md_election))

md_election_working <- select(md_election, receiving_committee, contributor_name, contribution_amount)
view(md_election_working)
md_election_working <- select(md_election, -receiving_committee)
view(md_election_working)

md_election_working <- md_election %>% 
select(-receiving_committee)
view(md_election_working)

md_election_working <- md_election %>%
  arrange(contribution_amount)
view(md_election_working)

md_election_working <- md_election %>%
  arrange(desc(contribution_amount))
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(receiving_committee == "Hogan Larry for Governor")
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(contribution_amount > 10000)
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(contribution_amount > 10000, receiving_committee == "Hogan Larry for Governor")
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(state == "VA" | state == "MD")
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(str_detect(contributor_name, "Republican"))
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(str_detect(contributor_name, "^Republican"))
view(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contributor_name, state, contribution_amount) %>%
  arrange(desc(contribution_amount))%>%
  filter(str_detect(contributor_name, "Maryland$"))
view(md_election_working)

install.packages('lubridate')
install.packages('dplyr')
library('lubridate')
library('tidyverse')

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(contribution_date > as_date("2017-12-31"))
View(md_election_working)

md_election_working <- md_election %>%
  select(receiving_committee, contribution_date, contributor_name, contribution_amount) %>%
  arrange(desc(contribution_amount)) %>%
  filter(year(contribution_date) == 2017)
View(md_election_working)

md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date))
view(md_election_working)

md_election_working <- md_election %>%
  mutate(contribution_year = year(contribution_date),
         contribution_month = month(contribution_date))
view(md_election_working)

md_election_working <- md_election %>%
  mutate(contribution_size = if_else(contribution_amount > 10000, "large_contribution", "small_contribution"))
view(md_election_working)

md_election_working <- md_election %>%
  mutate(contribution_size = case_when(
    contribution_amount > 20000 ~ "very large",
    contribution_amount > 10000 ~ "large",
    contribution_amount > 1000 ~ "medium",
    contribution_amount > 0 ~"small"))
view(md_election_working)

md_election_working <- md_election %>%
  mutate(contribution_times_10 = contribution_amount*10)
view(md_election_working)

md_election_working <- md_election %>%
  group_by(receiving_committee) %>%
  summarise(number_records = n()) %>%
  arrange(desc(number_records))
view(md_election_working)

md_election_working <- md_election %>%
  group_by(receiving_committee, state) %>%
  summarise(number_records = n()) %>%
  arrange(receiving_committee, desc(number_records))
view(md_election_working)

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
view(md_election_working)

# Mash up two strings together to create a new string with str_c(), similar to CONCATENATE in Excel. This uses mutate to create a brand new column called name_occupation that puts together the contents of the employer_occupation field and the employer_name field, with a dash separating them.

md_election_working <- md_election %>%
  mutate(name_occupation = str_c(employer_occupation, "-", employer_name))
view(md_election_working)

# Replace a value in a string.  This creates a new column called contributor_name_fixed from the original contributor_name, and replaces every instance of the word "Republican" with the word "GOP". To make it easy to see the change, it uses str_detect to filter out the rows that now have GOP in it.  Compare the contributor_name_fixed to contributor_name.  

md_election_working <- md_election %>%
  mutate(contributor_name_fixed = str_replace(contributor_name, "Republican", "GOP")) %>%
  filter(str_detect(contributor_name_fixed, "GOP"))
view(md_election_working)

# Trim whitespace from the beginning and end of a string with str_trim.  This is a common data cleaning problem that prevents grouping from happening properly. 

md_election_working <- md_election %>%
  mutate(cleaned_contributor_name = str_trim(contributor_name))

# To convert strings to upper or lower case, use str_to_upper or str_to_lower.  When we were doing joins, we saw that most records used "MD" for state, but some used "Md".  We can fix this with str_to_upper. 

md_election_working <- md_election %>%
  mutate(cleaned_state = str_to_upper(state))
view(md_election_working)

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

value_summary <- function(columnname){
  md_election_working <- md_election %>%
    summarise(count=n(), 
          total = sum(!!enquo(columnname)),
          average = mean(!!enquo(columnname)),
          median = median(!!enquo(columnname)))
    arrange(desc(count))
  View(md_election_working)
}

value_summary(contribution_amount)

min_max <- function(columnname){
  md_election_working <- md_election %>%
  summarise(minimum = min(!!enquo(columnname)),
            maximum = max(!!enquo(columnname)))
    arrange(desc(maximum))
  View(md_election_working)
}

min_max(contribution_amount)

library(lubridate)

month_year_date <- function(columnname){
  md_election_working <- md_election %>%
    mutate(year = year(!!enquo(columnname)),
         month = month(!!enquo(columnname))) %>%
    group_by(year, month) %>%
    arrange(year, month)
  View(md_election_working)
}

month_year_date(contribution_date)

# Then, go out and find at least ONE brand new to you R package -- it could be part of the tidyverse, could not be.  Load it in and attempt to use at LEAST one of the functions it provides.  You'll need to read the documentation, search stack overflow, look at cheatsheets. 
# Some greatest hits: https://awesome-r.com/
# All packages: https://cran.r-project.org/

#the git2r package (https://github.com/ropensci/git2r) seems useful because you can open, check, get summaries of and commit to exisiting repos or build new ones. I'll try to commit this script to my github r repo

install.packages("git2r")
library(git2r)

repo <- repository(F:/GitHub/rproj)

#I don't understand how to format "path" so I can't even load my existing repo

### Upload to ELMS.

