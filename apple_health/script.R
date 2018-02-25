setwd('/home/rxe/apple_health_export')
library(tidyverse)
library(lubridate)
library(here)

# Month strings
months_list <- c("January", "February", "March", 
                 "April", "May", "June", "July", 
                 "August", "September", "October", 
                 "November", "December")

#####################
## Helper function ##
#####################

clean_data <- function(data_frame){
  # Convert to date structure
  data_frame$startDate <- as.Date(data_frame$startDate)
  
  # Convert to date structure
  #data_frame['endDate'] <- as.Date(data_frame['endDate'])
  
  # Extract the months and create a column
  data_frame$month <- months(data_frame$startDate)
  
  # Extract the year and create a column
  data_frame$year <- year(data_frame$startDate)
  
  # Convert to ordered factor to output plot correctly 
  data_frame$month <- as.factor(data_frame$month)
  data_frame$month <- ordered(data_frame$month, levels = months_list)
  
  # Extract the weekday and create a column
  data_frame$week_day <- wday(data_frame$startDate, label = TRUE)
  return(data_frame)
}


##########################
## ACTIVE ENERGY BURNED ##
##########################
active_energy_burned <- read_csv(here::here('data', 'ActiveEnergyBurned.csv'))

# Use function to clean data frame 
active_energy_burned <- clean_data(active_energy_burned)

# Active Energy Burned by Weekday
active_energy_burned %>%
  filter(year == 2017) %>%
  group_by(week_day) %>%
  summarise(total_burned = sum(value)) %>%
  ggplot(., 
         aes(week_day, total_burned)) + 
  geom_bar(stat='identity',
           fill = '#004345') + 
  theme_minimal() +
  labs(x="Month", 
       y="Total (Energy Burned in kcal)") +
  ggtitle("Energy Burned by Weekday")

# Enery Burned by weekday 
active_energy_burned %>%
  filter(year == 2017) %>%
  group_by(month, week_day) %>%
  summarise(total_burned = sum(value)) %>%
  ggplot(., 
         aes(week_day, total_burned)) + 
  geom_bar(stat='identity',
           fill = '#004345',
           colour = "turquoise4") + 
  theme_bw() +
  facet_wrap(~month) +
  labs(x="Week Day", 
       y="Total (Energy Burned in kcal)") +
  ggtitle("Energy Burned by Weekday and Month")


# Active Energy Burned by Month
active_energy_burned %>%
  filter(year == 2017) %>% 
  ggplot(., 
       aes(month)) + 
  geom_bar(stat='count', 
           fill = '#004345') + 
  theme_minimal() #+ facet_wrap(~year)

##################################
## DISTANCE WALKING AND RUNNING ##
##################################

distance_running <- read_csv(here::here('data', 'DistanceWalkingRunning.csv'))

distance_running <- clean_data(distance_running)
# Active Energy Burned by Month
ggplot(distance_running, 
       aes(month)) + 
  geom_bar(stat='count', 
           fill = '#004345') + 
  theme_minimal() #+ facet_wrap(~year)

# Enery Burned by weekday 
distance_running %>%
  filter(year == 2017) %>% 
  ggplot(., 
         aes(week_day)) + 
  geom_bar(stat='count',
           fill = '#004345') + 
  facet_wrap(~month)

# 
ggplot(distance_running, 
       aes(value, month)) + 
  geom_joy() + 
  theme_minimal() 

#####################
## FLIGHTS CLIMBED ##
#####################
flights_climbed <- read_csv(here::here('data', 'FlightsClimbed.csv'))

flights_climbed <- clean_data(flights_climbed)

ggplot(flights_climbed, 
       aes(month)) + 
  geom_bar(stat='count', 
           fill = '#004345') + 
  theme_bw() + 
  facet_wrap(~value)

# Enery Burned by weekday 
flights_climbed %>%
  filter(year == 2017) %>% 
  ggplot(., 
         aes(week_day)) + 
  geom_bar(stat='count',
           fill = '#004345') + 
  facet_wrap(~month)

# 
ggplot(flights_climbed, 
       aes(value, month)) + 
  geom_joy() + 
  theme_minimal() 

################
## STEP COUNT ##
################
step_count <- read_csv(here::here('data', 'StepCount.csv'))

step_count <- clean_data(step_count)

ggplot(step_count, 
       aes(month)) + 
  geom_bar(stat='count', 
           fill = '#004345') + 
  theme_minimal()

# Enery Burned by weekday 
step_count %>%
  filter(year == 2017) %>% 
  ggplot(., 
         aes(week_day)) + 
  geom_bar(stat='count',
           fill = '#004345') + 
  facet_wrap(~month)

# 
ggplot(step_count, 
       aes(x = value, y = month, 
           group = month)) + 
  geom_joy() + 
  theme_minimal() 
