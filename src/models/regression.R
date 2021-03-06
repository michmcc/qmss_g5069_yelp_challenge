#################
# Yelp Project
# Regression
# 04/02/2017
#################

library(tidyverse)
require(stargazer)

# load data

topics <- read.csv("../../data/processed/business_topics.csv")
topics <- topics %>%
  select(business_id, review_cnt, topic_1, topic_2, topic_3, topic_4)

load("../../data/processed/review_summary.RData")
reviews <- review_summary %>%
  select(business_id, sumBID, meannum, meansentiment)

business <- read.csv("../../data/processed/b_categories.csv")
drop <- c("X", "X.1", "neighborhood", "longitude", "hours", "state", "postal_code", "categories", "address", "latitude", "review_count", "attributes", "type", "is_open", "restaurant", "city_type", "global_restaurant", "us_restaurant")
business <- business %>%
  select(-one_of(drop))

total <- inner_join(reviews, topics)
total <- inner_join(total, business)

# regression model
# cuisine
cuisine1 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Charlotte")
cuisine2 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Cleveland")
cuisine3 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Las Vegas")
cuisine4 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Mesa")
cuisine5 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Phoenix")
cuisine6 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Pittsburgh")
cuisine7 <- lm(stars ~ American..New. + American..Traditional. + Southern + Mexican + Chinese + Japanese + Thai + Indian + French + Italian + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Scottsdale")

stargazer(cuisine1, cuisine2, cuisine3, cuisine4, cuisine5, cuisine6, cuisine7, type = 'html'
          , out = "../../reports/cuisine_model_output.html", out.header = TRUE)

# dietary
dietary1 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Charlotte")
dietary2 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Cleveland")
dietary3 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Las Vegas")
dietary4 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Mesa")
dietary5 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Phoenix")
dietary6 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Pittsburgh")
dietary7 <- lm(stars ~ Vegetarian + Vegan + Kosher + Halal + Gluten.Free + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Scottsdale")

stargazer(dietary1, dietary2, dietary3, dietary4, dietary5, dietary6, dietary7, type = 'html'
          , out = "../../reports/dietary_model_output.html", out.header = TRUE)

# type of setting
setting1 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Charlotte")
setting2 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Cleveland")
setting3 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Las Vegas")
setting4 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Mesa")
setting5 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Phoenix")
setting6 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Pittsburgh")
setting7 <- lm(stars ~ Cafes + Bars + Pubs + Fast.Food + Food.Trucks + Diners + meansentiment + sumBID + meannum + topic_1 + topic_2 + topic_3 + topic_4, data = total, subset = city == "Scottsdale")

stargazer(setting1, setting2, setting3, setting4, setting5, setting6, setting7, type = 'html'
          , out = "../../reports/setting_model_output.html", out.header = TRUE)

