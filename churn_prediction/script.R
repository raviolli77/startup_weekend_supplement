library(tidyverse)
library(GGally)
library(here)
customer_churn <- read_csv(here::here("data", "customer-churn.csv"))

View(customer_churn)

customer_churn_no_id <- customer_churn %>% 
  select(-c(customerID))

summary(customer_churn$TotalCharges)
which(is.na(customer_churn$TotalCharges))

View(customer_churn[489, ])
ggplot(customer_churn, 
       aes(PhoneService, MonthlyCharges, fill = tenure)) + 
  geom_raster()

ggpairs(customer_churn_no_id)

ggplot(customer_churn, aes(PaymentMethod, MonthlyCharges)) +
  geom_boxplot() +
  facet_wrap(~ Churn) +
  theme_bw()

ggplot(customer_churn, aes(gender, MonthlyCharges)) +
  geom_boxplot() +
  facet_wrap(~ Churn) +
  theme_bw()

ggplot(customer_churn, aes(Dependents, MonthlyCharges)) +
  geom_boxplot() +
  facet_wrap(~ Churn) +
  theme_bw()


ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE)

# PHONE SERVICES
ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE) +
  theme_minimal()

# FACET WRAPPING TO SEE MORE PATTERNS
ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE) +
  facet_wrap( ~ PhoneService) +
  theme_bw()

#
ggplot(customer_churn,
       aes(tenure, TotalCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE) +
  facet_grid(Churn ~ InternetService) +
  theme_bw()


ggplot(customer_churn,
       aes(tenure, MonthlyCharges,
           colour = PhoneService)) +
  geom_point(na.rm = TRUE) +
  facet_wrap( ~ Churn) +
  theme_bw()


ggplot(customer_churn,
       aes(TotalCharges, MonthlyCharges,
           colour = Contract)) +
  geom_point(na.rm = TRUE) +
  facet_wrap( ~ Churn) +
  theme_bw()
