#################
# Yelp Project
# Word Cloud Visualizations
# 03/21/2017
#################

load("../../data/processed/terms_4.RData")

#require(devtools)
#install_github("lchiffon/wordcloud2")
require(wordcloud2)


wc_df <- data.frame(word = terms_4$word, freq = terms_4$X1)
wc_df <- wc_df[order(-wc_df$freq),]
wordcloud2(wc_df[1:15,], shape = "circle", size = .20, rotateRatio = 0, color = "#005ce6")


wc_df <- data.frame(word = terms_4$word, freq = terms_4$X2)
wc_df <- wc_df[order(-wc_df$freq),]
wordcloud2(wc_df[1:15,], shape = "circle", size = .5, rotateRatio = 0, color = "#cc0000")


wc_df <- data.frame(word = terms_4$word, freq = terms_4$X3)
wc_df <- wc_df[order(-wc_df$freq),]
wordcloud2(wc_df[1:15,], shape = "circle", size = .25, rotateRatio = 0, color = "#7575a3")

wc_df <- data.frame(word = terms_4$word, freq = terms_4$X4)
wc_df <- wc_df[order(-wc_df$freq),]
wordcloud2(wc_df[1:15,], shape = "circle", size = .35, rotateRatio = 0, color = "#39ac73")
