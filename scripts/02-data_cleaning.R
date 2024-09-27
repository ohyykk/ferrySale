#### Preamble ####
# Purpose: Cleans the FerrySale data obtained
# Author: Yingke He
# Date: 26 September 2024
# Contact: kiki.he@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed: NA

#### Workspace Set Up ####

library(tidyverse)
library(opendatatoronto)

#### Cleaning the data set ####
# read file first
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Data Cleaning Steps # 1. Remove rows with missing values 
raw_data <- raw_data %>% drop_na() 
# 2. Convert Timestamp to proper date-time format 
raw_data <- raw_data %>% mutate(Timestamp = as.POSIXct(Timestamp, format = "%Y-%m-%d %H:%M:%S")) 
# 3. Remove duplicates 
raw_data <- raw_data %>% distinct() 
# 4. Filter out unrealistic values (example: negative sales or redemption counts) 
raw_data <- raw_data %>% filter(Redemption.Count >= 0, Sales.Count >= 0)

cleaned_data <- raw_data
write_csv(cleaned_data, cleaned_data_path)
data <- read_csv(cleaned_data_path, show_col_types = FALSE)