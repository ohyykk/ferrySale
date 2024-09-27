#### Preamble ####
# Purpose: Tests the integrity of raw and processed FerrySale data
# Author: Yingke He
# Date: 26 September 2024
# Contact: kiki.he@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed: NA

#### Workspace setup ####
library(testthat)
library(readr)
library(lubridate)

#### Load data ####
# Replace the paths below with your actual data paths
ferry_data <- read_csv("data/raw_data/unedited_data.csv")

#### Test data ####

# Test Suite for Ferry Data
test_that("Check column types in ferry_data dataset", {
  
  # Test that 'Timestamp' column is in DateTime format
  expect_true(class(ferry_data$Timestamp) == "character", 
              info = "'Timestamp' column should initially be in character format")
  
  # Convert 'Timestamp' to Date-Time and validate
  ferry_data$Timestamp <- ymd_hms(ferry_data$Timestamp)
  expect_true(class(ferry_data$Timestamp) == "POSIXct", 
              info = "'Timestamp' column should be in POSIXct (DateTime) format after conversion")
  
  # Test that 'Redemption.Count' and 'Sales.Count' columns are numeric
  expect_true(is.numeric(ferry_data$Redemption.Count), 
              info = "'Redemption.Count' column should be numeric")
  expect_true(is.numeric(ferry_data$Sales.Count), 
              info = "'Sales.Count' column should be numeric")
})

# Check that 'X_id', 'Redemption.Count', and 'Sales.Count' columns do not have any missing values
test_that("Check for missing values in key columns", {
  expect_false(any(is.na(ferry_data$X_id)), 
               info = "'X_id' column should not have missing values")
  expect_false(any(is.na(ferry_data$Redemption.Count)), 
               info = "'Redemption.Count' column should not have missing values")
  expect_false(any(is.na(ferry_data$Sales.Count)), 
               info = "'Sales.Count' column should not have missing values")
})

# Test to check that all 'Redemption.Count' and 'Sales.Count' values are non-negative
test_that("Check that counts are non-negative", {
  expect_true(all(ferry_data$Redemption.Count >= 0), 
              info = "'Redemption.Count' should be non-negative")
  expect_true(all(ferry_data$Sales.Count >= 0), 
              info = "'Sales.Count' should be non-negative")
})

# Test to check that 'X_id' is unique for each entry
test_that("Check that 'X_id' is unique", {
  x_id_unique <- n_distinct(ferry_data$X_id) == nrow(ferry_data)
  expect_true(x_id_unique, 
              info = "'X_id' should be unique for each entry")
})

# Test to check that the 'Timestamp' column contains valid timestamps
test_that("Check that 'Timestamp' is within valid range", {
  
  # Define a range for valid timestamps (adjust as needed)
  start_date <- as.POSIXct("2024-01-01 00:00:00")
  end_date <- Sys.time()  # Up to current time
  
  # Check that all timestamps fall within the specified range
  expect_true(all(ferry_data$Timestamp >= start_date & ferry_data$Timestamp <= end_date), 
              info = "All 'Timestamp' values should be within the expected date range")
})

#### Save cleaned data (if tests pass) ####
write_csv(ferry_data, "data/cleaned_data/cleaned_ferry_data.csv")
