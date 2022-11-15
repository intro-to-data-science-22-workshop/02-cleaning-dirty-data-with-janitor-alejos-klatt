### EXERCISE SOLUTIONS

# REQUIRED PACKAGES
library(readr)
library(tidyverse)
library(janitor)


### IMPORT CRIME DATASET
crime_df <- read_delim("crime_subset.csv", 
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)



### EXERCISE 1: Change variable names of the data frame to follow `snake_case` convention.

crime_df <- crime_df %>% 
  clean_names()
crime_df %>% 
  names()  # insert your answer here

# changing writing style to upper_camel
crime_df %>% 
  clean_names(case = "upper_camel", abbreviations = c("ID", "NIBRS")) %>% 
  names()   

### Exercise 2:** Find out whether there are any duplicate values in `crime_df` data frame

crime_df %>% 
  get_dupes(crime_name2,crime_name1,victims, cr_number) %>% 
  arrange(desc(dupe_count))
          
          
### Exercise 3.1: Create a subset called *tidy_crime* using the `remove_empty()`

tidy_crime <-  crime_df %>% 
  remove_empty(c("rows","cols"), quiet = F)

glimpse(tidy_crime)


### EXERCISE 3.2: Using `crime_df`, subset the crimes committed in *Silver Spring 
#district, clean the data and get rid of the `police_distric_name` variable. 

s_silver_spring <-  crime_df %>% 
  filter(police_district_name == "SILVER SPRING") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F)

crime_df %>% 
  filter(police_district_name == "SILVER SPRING") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F) %>% 
  glimpse()


### Exercise 4: Using `crime_df`, subset the crimes committed in *Wheaton*, 
# clean the data and get rid of the *police_distric_name* variable. Compare the
# new subset with the *Silver Spring* subset. Check out what columns are missing 
# or present in the different inputs. 


s_wheaton <- crime_df %>% 
  filter(police_district_name == "WHEATON") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F)

compare_df_cols(s_silver_spring, s_wheaton)


### EXERCISE 5.1: Use the data frame *tidy_crime* to create a frequency table for 
#*police_distric_name* variable with percentages rounded to 1 digit.  

tabyl(tidy_crime$police_district_name) %>% 
  adorn_pct_formatting(digits = 1) 

### EXERCISE 5.2: Now, create a two-way contingency table for the *Silver Spring* 
# subset and tell us what percentage corresponds to crime against property if there 
# is 1 victim as result of the attack. DON'T USE `drop_na()`

s_silver_spring %>% 
  tabyl(crime_name1, victims) %>%
  adorn_totals("row") %>%
  adorn_percentages("col")  %>%
  adorn_pct_formatting(digits= 1)  %>%
  adorn_ns()  %>%
  adorn_title() 

### Rounding up numbers
# Create a vector of 10 elements. Create new vectors in which the numbers from vector 
# 1 are rounded up to 1 and 0 digits respectively, then create a tibble under the name 
# `funny_numbers` to compare.

v1 <- runif(10, min=15, max=48)
v2 <- round_half_up(v1, digits = 1)
v3 <- round_half_up(v1)

funny_numbers <- tibble(v1,v2,v3)
funny_numbers

### Playing with dates
# Use the `excel_numeric_to_date()` function to convert Excel serial date numbers
# in *edates* to class `Date`
edates <- c(0, 59, 61, 1000, 45100)

edates %>% 
  excel_numeric_to_date()
  