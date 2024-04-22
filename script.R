# Host is super host

# Has 10 or more total listings

# Average review above 4.5 stars


#df = read.csv("listings.csv")

# head(df, 5)

desired_columns <- c("id", 
                     "host_id", 
                     "host_name", 
                     "host_since", 
                     "host_is_superhost", 
                     "host_listings_count", 
                     "host_total_listings_count", 
                     "review_scores_rating", 
                     "review_scores_accuracy", 
                     "review_scores_cleanliness", 
                     "review_scores_checkin", 
                     "review_scores_communication", 
                     "review_scores_location", 
                     "review_scores_value")


#Filter by desired columns from above
filtered_df <- df[, desired_columns]

# Filter by host being a superhost
filtered_df <- subset(filtered_df, host_is_superhost == "t")

# Filter by total listings greater than 10 for a single host
filtered_df = subset(filtered_df, host_total_listings_count >= 10)

# Filter by host having average review score greater than 4.5
filtered_df$avg_review_score <- rowMeans(filtered_df[, c("review_scores_rating", 
                                                         "review_scores_accuracy", 
                                                         "review_scores_cleanliness", 
                                                         "review_scores_checkin", 
                                                         "review_scores_communication", 
                                                         "review_scores_location", 
                                                         "review_scores_value")], na.rm = TRUE)

filtered_df <- filtered_df[filtered_df$avg_review_score >= 4.5, ]

# Get unique hosts
filtered_df <- filtered_df[!duplicated(filtered_df$host_id), ]

# Filter by host being an Airbnb host since before 2018
filtered_df$host_since <- as.Date(filtered_df$host_since)

filtered_df <- filtered_df[filtered_df$host_since < as.Date("2018-01-01"), ]

# Omit NA values
filtered_df <- na.omit(filtered_df)

#nrow(filtered_df)

head(filtered_df, 5)