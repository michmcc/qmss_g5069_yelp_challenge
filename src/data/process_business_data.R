#########################
# Yelp Project
# Process Business CSV
# 02/27/2017
#########################

# Read in Business CSV
print("Reading in interim business csv file")
business <- read.csv("../../data/interim/business.csv")

# Function to convert to vector
convert_to_vector <- function(x) {
  x <- as.character(x)
  x <- gsub("\\[u\\'", "\\'", x)
  x <- gsub(", u\\'", ", \\'", x)
  x <- gsub(',\\s', ',', x)
  x <- gsub('\\[', '', x)
  x <- gsub(']', '', x)
  x <- gsub("\\'", "", x)
  x <- as.vector(strsplit(x, ","))[[1]]
  return(x)
}

# Convert attributes and categories to lists of vectors
print("converting category variable to list of vectors")
business$categories_l <- lapply(business$categories, convert_to_vector)
#business$attributes_l <- lapply(business$attributes, convert_to_vector)

# Dummy variable for Restaurants
print("creating dummy variables")
business$restaurant <- unlist(lapply(business$categories_l, function(x) {unlist(ifelse("Restaurants" %in% x, 1, 0))}))

# QA against exploratory restaurant counts
# agg <- aggregate(business$restaurant, by=list(city=business$city), FUN=sum)
# agg <- subset(agg, x > 500)
# agg[order(agg$x, decreasing = TRUE),]

# Number of categories per business
# table(unlist(lapply(business$categories_l, length)))

# Output files
print("output processed business csv")
write.csv(business[, !(names(business) == "categories_l")], "../../data/processed/business.csv")

print("output new restaurants csv")
write.csv(business[business$restaurant == 1, !(names(business) == "categories_l")], "../../data/processed/restaurants.csv")
