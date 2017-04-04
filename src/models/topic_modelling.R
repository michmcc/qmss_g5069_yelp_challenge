#################
# Yelp Project
# Topic Modelling
# 03/21/2017
#################

library(topicmodels)
#library(dplyr)
library(stringr)


## load previous document term matrix
#load("../../data/processed/cpdtm.RData")

# load unstemmed document term matrix
#load("../../data/processed/cpdtm_unstem.RData")

# load TRAINING unstemmed BIGRAM document term matrix
load("../../data/processed/cpdtm_unstem_bi_train.RData")

# load FULL
load("../../data/processed/cpdtm_unstem_bi.RData")


## LDA
## set 5 topics
#k <- 5
#output <- LDA(cpdtm, k)




## show 10 terms associated with each model
#terms(output, 10)

## trying on unstemmed data

## set 5 topics
#k <- 3
#output <- LDA(cpdtm_unstem, k, method = "Gibbs")


## bigram unstemmed data

## set 4 topics
set.seed(1234)
k <- 3
output_3 <- LDA(cpdtm_unstem_bi_train, k, control=list(seed=1), method = "Gibbs")


k <- 4
output_4 <- LDA(cpdtm_unstem_bi_train, k, control=list(seed=1), method = "Gibbs")


k <- 5
output_5 <- LDA(cpdtm_unstem_bi_train, k, control=list(seed=1), method = "Gibbs")

# output words per topic
terms(output_3, 15)


# get probability of each word to a particular topic
terms_3 <- as.data.frame(t(posterior(output_3)$terms))
terms_3 <- data.frame(word = rownames(terms_3), terms_3, row.names = NULL)

terms_4 <- as.data.frame(t(posterior(output_4)$terms))
terms_4 <- data.frame(word = rownames(terms_4), terms_4, row.names = NULL)

terms_5 <- as.data.frame(t(posterior(output_5)$terms))
terms_5 <- data.frame(word = rownames(terms_5), terms_5, row.names = NULL)


## output terms for word clouds
save(terms_3, file = "../../data/processed/terms_3.Rdata")
save(terms_4, file = "../../data/processed/terms_4.Rdata")
save(terms_5, file = "../../data/processed/terms_5.Rdata")

# perplexity analysis (TBC)
#p_k_10 <- perplexity(output, cpdtm_unstem_bi)



# assign topic to each review in the FULL training set
full.topics <- posterior(output,cpdtm_unstem_bi)
full.topics <- apply(full.topics$topics, 1, which.max)

review_topics <- as.data.frame(full.topics)
review_topics <- data.frame(business_review_id = rownames(review_topics), review_topics, row.names = NULL)

review_topics$business_id <- str_split_fixed(review_topics$business_review_id, "/", 2)[,1]
review_topics$review_id <- str_split_fixed(review_topics$business_review_id, "/", 2)[,2]

review_topics <- review_topics[, c("business_id", "review_id", "full.topics")]

business_topic_cnt <- as.data.frame.matrix(table(review_topics$business_id, review_topics$full.topics))
business_topic_cnt <- data.frame(business_id = rownames(business_topic_cnt), business_topic_cnt, row.names = NULL)
colnames(business_topic_cnt) <- c("business_id", "topic_1", "topic_2", "topic_3")

business_review_cnt <- as.data.frame(table(review_topics$business_id))
colnames(business_review_cnt) <- c("business_id", "review_cnt")

business_topics <- merge(business_review_cnt, business_topic_cnt)


## output for each business, the proportion of reviews corresponding to each topic
write.csv(business_topics, file = "../../data/processed/business_topics.csv")

