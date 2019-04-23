
## check values

md_election_working <- md_election %>%
  group_by(filing_period) %>%
  summarise(count=n()) %>%
  arrange(desc(count))
View(md_election_working)

## We could run through these for the next column

md_election_working <- md_election %>%
  group_by(contributor_name) %>%
  summarise(count=n()) %>%
  arrange(desc(count))
View(md_election_working)

## We could keep writing this again and again, or we could build a function 

column_check <- function(columnname){
  md_election_working <- md_election %>%
    group_by(!!enquo(columnname)) %>%
    summarise(count=n()) %>%
    arrange(desc(count))
  View(md_election_working)
}

glimpse(md_election)

column_check(zip_code)
column_check(state)
column_check(contributor_type)

