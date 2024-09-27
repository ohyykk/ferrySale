#### Preamble ####
# Purpose: Downloads and saves the data from the FerrySale dataset package
# Author: Yingke He
# Date: 26 September 2024
# Contact: kiki.he@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed: NA

#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr)

# Get package using the search term "Toronto Island Ferry Ticket Counts"
ferry_ticket_packages <- search_packages("Toronto Island Ferry Ticket Counts")

# Get all resources for this package (using the package ID for the "Toronto Island Ferry Ticket Counts")
resources <- list_package_resources(ferry_ticket_packages$id[1])

# Identify the datastore resources
datastore_resources <- resources %>%
  filter(tolower(format) == "datastore")

# Load the first datastore resource as a sample
data <- datastore_resources %>%
  filter(row_number() == 1) %>%
  get_resource()

# Save the loaded data
raw_data_path <- "/Users/kiki/Desktop/STA304/paper1/ferrySale/scripts/raw_data.csv"

# Write the raw data to a CSV file
write_csv(data, raw_data_path)

# Read the saved raw data
raw_data <- read_csv(raw_data_path, show_col_types = FALSE)

#### Save data ####
write_csv(raw_data, "data/raw_data/raw_data.csv")
