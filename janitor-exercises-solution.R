### EXERCISE SOLUTIONS

# REQUIRED PACKAGES
library(readr)
library(tidyverse)
library(janitor)


### IMPORT CRIME DATASET
crime_df <- read_delim("crime_subset.csv", 
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)



### EXERCISE 1: 

crime_df <- crime_df %>% 
  clean_names()
crime_df %>% 
  names()  # insert your answer here

# changing writing style to upper_camel
crime_df %>% 
  clean_names(case = "upper_camel", abbreviations = c("ID", "NIBRS")) %>% 
  names()   

### Exercise 2:** 

crime_df %>% 
  get_dupes(crime_name2,crime_name1,victims, cr_number) %>% 
  arrange(desc(dupe_count))
          
          
### Exercise 3.1: 

tidy_crime <-  crime_df %>% 
  remove_empty(c("rows","cols"), quiet = F)

glimpse(tidy_crime)


### EXERCISE 3.2: 

s_silver_spring <-  crime_df %>% 
  filter(police_district_name == "SILVER SPRING") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F)

crime_df %>% 
  filter(police_district_name == "SILVER SPRING") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F) %>% 
  glimpse()


### Exercise 4: 


s_wheaton <- crime_df %>% 
  filter(police_district_name == "WHEATON") %>% 
  remove_empty(c("rows","cols"), quiet = F) %>% 
  remove_constant(quiet = F)

compare_df_cols(s_silver_spring, s_wheaton)


### EXERCISE 5.1:   

tabyl(tidy_crime$police_district_name) %>% 
  adorn_pct_formatting(digits = 1) 

### EXERCISE 5.2:

s_silver_spring %>% 
  tabyl(crime_name1, victims) %>%
  adorn_totals("row") %>%
  adorn_percentages("col")  %>%
  adorn_pct_formatting(digits= 1)  %>%
  adorn_ns()  %>%
  adorn_title() 

### Rounding up numbers

v1 <- runif(10, min=15, max=48)
v2 <- round_half_up(v1, digits = 1)
v3 <- round_half_up(v1)

funny_numbers <- tibble(v1,v2,v3)
funny_numbers

### Playing with dates

edates <- c(0, 59, 61, 1000, 45100)

edates %>% 
  excel_numeric_to_date()
  