#################
# Yelp Project
# Topic Modelling
# 03/21/2017
#################

library(topicmodels)

## load previous document term matrix
load("../../data/processed/cpdtm.RData")

## LDA
## set 5 topics
k <- 5
output <- LDA(cpdtm, k)

## show 10 terms associated with each model
terms(output, 10)