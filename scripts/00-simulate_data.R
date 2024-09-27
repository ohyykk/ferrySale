#### Preamble ####
# Purpose: Simulates a dataset representing Toronto's Island Ferry Ticket Counts
# Author: Yingke He
# Date: 26 September 2024
# Contact: kiki.he@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed: NA



#### Workspace setup ####
library(tidyverse)
library(dplyr)



#### Simulate data ####
# Set seed for reproducibility
set.seed(123)

# Number of rows to simulate
n <- 100

# Simulating the data
simulated_data <- data.frame(
  X_id = 1:n,
  Timestamp = seq.POSIXt(from = as.POSIXct("2024-09-25 16:45:00"),
                         by = "15 mins", length.out = n),
  Redemption.Count = round(rnorm(n, mean = 35, sd = 10)),  # Mean and SD based on observed values
  Sales.Count = round(rnorm(n, mean = 32, sd = 10))        # Mean and SD based on observed values
)

# Ensure that counts are non-negative
simulated_data <- simulated_data %>%
  mutate(Redemption.Count = ifelse(Redemption.Count < 0, 0, Redemption.Count),
         Sales.Count = ifelse(Sales.Count < 0, 0, Sales.Count))

# Print the first few rows of the simulated data for checking purposes
head(simulated_data)
