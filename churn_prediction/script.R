library(tidyverse)
library(GGally)
library(here)
customer_churn <- read_csv(here::here("churn_prediction", "customer-churn.csv"))

customer_churn <- customer_churn %>% 
  select(-c(customerID))

customer_churn %>%
  count(Churn)

customer_churn %>%
  filter(Churn == "Yes") %>%
  count(Contract)

customer_churn %>%
  filter(Churn == "No") %>%
  count(Contract)

# Exploring Features Based on Feature Importance for GBM Model 

## Total Charges
ggplot(customer_churn_no_id, 
       aes(TotalCharges, 
           fill=Contract)) + 
  geom_histogram(bins = 100, 
                 na.rm = TRUE) +
  facet_wrap(~Churn) + 
  theme_bw() + 
  labs(x = "Total Charges", y = "Total") + 
  ggtitle("Total Charges Vs. Churn \n(IBM Customer Churn Data Set)") + 
  scale_fill_manual(values = c("#004345", "#8b0086", "#868b00"))

# Monthly Charges
ggplot(customer_churn_no_id, 
       aes(MonthlyCharges, fill=Contract)) + 
  geom_histogram(bins = 200, 
                 na.rm = TRUE) +
  facet_wrap(~Churn) + 
  theme_bw() + 
  labs(x = "Monthly Charges", y = "Total") + 
  ggtitle("Monthly Charges Vs. Churn \n(IBM Customer Churn Data Set)") + 
  scale_fill_manual(values = c("#004345", "#8b0086", "#868b00"))

# Tenure
ggplot(customer_churn_no_id, 
       aes(tenure, fill=Contract)) + 
  geom_histogram(bins=75, 
                 na.rm = TRUE) +
  facet_wrap(~Churn) + 
  theme_bw() + 
  labs(x = "Tenure", y = "Total") + 
  ggtitle("Tenure Vs. Churn Comparison \n(IBM Customer Churn Data Set)") + 
  scale_fill_manual(values = c("#004345", "#8b0086", "#868b00"))

# More Exploration on Data set
ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE,
             pch=22) + 
  theme_minimal() + 
  labs(x = "Tenure", y = "Total Charges") + 
  ggtitle("Tenure Vs. Total Charges \n(IBM Customer Churn Data Set)") + 
  scale_colour_manual(values = c("#8b0086", "#004345"))

ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE) + 
  facet_grid(InternetService ~ Churn) + 
  theme_bw() + 
  scale_shape(solid=FALSE) + 
  scale_colour_manual(values = c("#8b0086", "#004345"))

# FACET WRAPPING TO SEE MORE PATTERNS
ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = InternetService)) +
  geom_point(na.rm = TRUE) +
  facet_wrap( ~ PhoneService) +
  theme_bw()
