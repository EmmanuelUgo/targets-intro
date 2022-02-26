
library(targets)

source('R/functions.R')

tar_option_set(packages = c("tidyverse","scales","janitor","fs"))

list(
  tar_target(stg_loan_data, dir_ls("data/"), format = "file"),
  
  tar_target(import_data, read_csv(stg_loan_data)),
  
  tar_target(data_cleaning, clean_data(import_data)),
  
  tar_target(get_income_by_gender, income_by_gender(data_cleaning)),
  
  tar_target(get_count_of_applicants, count_of_applicants(data_cleaning))
)