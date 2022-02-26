

clean_data <- function(tbl){
  
  tbl %>%
    janitor::clean_names() %>%
    mutate_at(c("gender","dependents","education",
                "loan_status", "property_area", "gender",
                "married", "self_employed", "credit_history"),factor) %>%
    drop_na()
  
}

income_by_gender <- function(tbl){
  
  tbl %>% 
    count(gender,education , wt = median(applicant_income)) %>% 
    ggplot(aes(gender, n, fill = education)) +
    geom_col(position = position_dodge2(), width = 0.75) +
    geom_hline(yintercept = median(tbl$applicant_income),
               lty = 2, col = "gray50") +
    annotate("text", x = 2.3,
             y = median(tbl$applicant_income) + 0.05 * median(tbl$applicant_income), 
             label = "Median Salary") +
    scale_y_continuous(labels = scales::dollar) +
    labs(
      title = "\nMedian Salary of Loan Applicants",
      y = "Median Salary",
      x = "",
      fill = ""
    ) +
    theme_minimal() +
    theme(
      legend.position = "bottom",
      plot.title = element_text(hjust = 0.5)
    ) +
    guides(
      fill = guide_legend(label.position = "bottom",
                          keywidth = unit(25, "mm"),
                          keyheight = unit(2.5, "mm"))
    ) 
  
  
}

count_of_applicants <- function(tbl){
  
  tbl %>% 
    count(loan_status) %>% 
    ggplot(aes(loan_status, n)) +
    geom_col() +
    labs(
      title = "\n Overview of Loan Status",
      y = "# of Candidates.",
      x = "Loan Status"
    ) +
    theme_minimal()
  
  
}



