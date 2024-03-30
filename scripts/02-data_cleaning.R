#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("inputs/data/plane_data.csv")


tidydataset <- shakes %>%
  unnest_tokens(word, text)

gutenberg_download(768)

# You can use the tidytext stop_words dataset
data(stop_words)

# Just use anti_join() to specify the name of the dataset with words that need to be excluded 
tidydataset <- tidydataset %>%
  anti_join(stop_words)

# Use count() to quickly get the count of the most frequently used words
tidydataset %>%
  count(word, sort = TRUE)

# Convert to Corpus
corpus <- Corpus(VectorSource(text$text))

# Perform text preprocessing
corpus_clean <- tm_map(corpus, content_transformer(tolower))
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords("english"))
corpus_clean <- tm_map(corpus_clean, stripWhitespace)

# Convert the corpus to a tidy format
tidy_corpus <- tidy(corpus_clean)

# Calculate word frequencies
word_freq <- tidy_corpus %>%
  count(word, sort = TRUE)

# Visualize word frequencies (e.g., bar plot or word cloud)
# Example using ggplot2 for bar plot
top_words <- head(word_freq, 20)
ggplot(top_words, aes(x = reorder(word, -n), y = n)) +
  geom_bar(stat = "identity") +
  labs(x = "Word", y = "Frequency", title = "Top 20 Most Frequent Words")




cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(wing_width_mm, wing_length_mm, flying_time_sec_first_timer) |>
  filter(wing_width_mm != "caw") |>
  mutate(
    flying_time_sec_first_timer = if_else(flying_time_sec_first_timer == "1,35",
                                   "1.35",
                                   flying_time_sec_first_timer)
  ) |>
  mutate(wing_width_mm = if_else(wing_width_mm == "490",
                                 "49",
                                 wing_width_mm)) |>
  mutate(wing_width_mm = if_else(wing_width_mm == "6",
                                 "60",
                                 wing_width_mm)) |>
  mutate(
    wing_width_mm = as.numeric(wing_width_mm),
    wing_length_mm = as.numeric(wing_length_mm),
    flying_time_sec_first_timer = as.numeric(flying_time_sec_first_timer)
  ) |>
  rename(flying_time = flying_time_sec_first_timer,
         width = wing_width_mm,
         length = wing_length_mm
         ) |> 
  tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
