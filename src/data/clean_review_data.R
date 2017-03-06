###################
# Yelp Project
# Text Cleaning
# 03/04/2016
###################

library(tidyverse)
library(tidytext)
library(SnowballC)
library(tm)
library(Matrix)

## read dataset

dataset <- read.csv("../../data/processed/us_restaurant_reviews_50.csv", row.names = NULL)

## tidy corpus

corpus <- dataset %>%
  select(business_id, review_id, text, stars, date, useful) %>%
  separate(date, into = c("year", "month", "day")) %>%
  mutate(
    year = as.integer(year),
    month = as.integer(month),
    day = as.integer(day),
    text = as.character(text),
    business_id = as.character(business_id),
    review_id = as.character(review_id)
  ) %>%
  unite(biz_review_id, business_id, review_id, sep = "/")

## clean text

data("stop_words")

corpus_token <- corpus %>%
  ungroup() %>%
  unnest_tokens(word, text) %>%   # tokenize, remove punctuation, lowercase
  anti_join(stop_words) %>%       # remove stopwords
  mutate(word = wordStem(word))   # stem words

## create full document term matrix

cp <- corpus_token[, c("biz_review_id", "word")]
cp_count <- count_(cp, c("biz_review_id", "word"))
cpdtm <- cp_count %>%
  cast_dtm(biz_review_id, word, n)
cpdtm_matrix <- sparseMatrix(cpdtm$i, cpdtm$j, x = cpdtm$v,
                             dims = c(cpdtm$nrow, cpdtm$ncol),
                             dimnames = cpdtm$dimnames)

