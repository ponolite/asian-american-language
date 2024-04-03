#### Preamble ####
# Purpose: Clean the self-generated datasets 
# Author: Quang Mai
# Date: 30 March 2024 
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: Read four raw datasets containing the novel texts from five authors

#### Workspace setup ####
library(tidyverse)
library(tidytext)
library(rmarkdown)
library(gutenbergr)
library(tm)
library(dplyr)
library(ggplot2)
library(scales)


#### Clean data ####
portrait <- read_csv("data/raw_data/portrait.csv")
swann <- read_csv("data/raw_data/swann_way.csv")
dalloway <- read_csv("data/raw_data/mrs_dalloway.csv")
bliss <- read_csv("data/raw_data/bliss.csv")
prufrock <- read_csv("data/raw_data/prufrock.csv")


# Tokenize the words from the text, breaking the text down into individual words to insert them into individual datasets
# Codes sourced from https://medium.com/the-data-nudge/nlp-basics-exploring-word-frequency-with-the-tidytext-r-package-ac35a6d805f4

portrait_tokenized <- portrait |>
  na.omit(portrait) |>
  unnest_tokens(word, text) 

swann_tokenized <- swann |>
  na.omit(swann) |>
  unnest_tokens(word, text)

dalloway_tokenized <- dalloway |>
  na.omit(dalloway) |>
  unnest_tokens(word, text)

prufrock_tokenized <- prufrock |>
  na.omit(prufrock) |>
  unnest_tokens(word, text)

bliss_tokenized <- bliss |>
  na.omit(bliss) |>
  unnest_tokens(word, text)

# Exclude stop word using the tidytext stop_words dataset, also, use anti_join() to specify the name of the dataset with words that need to be excluded
data(stop_words)

portrait_clean <- portrait_tokenized |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1)

swann_clean <- swann_tokenized |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1)

dalloway_clean <- dalloway_tokenized |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1)

bliss_clean <- bliss_tokenized |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1)

prufrock_clean <- prufrock_tokenized |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1)

# Use count() to quickly get the count of the most frequently used words
portrait_words <- portrait_clean |>
  count(word, sort = TRUE)

swann_words <- swann_clean |>
  count(word, sort = TRUE)

dalloway_words <- dalloway_clean |>
  count(word, sort = TRUE)

bliss_words <- bliss_clean |>
  count(word, sort = TRUE)

prufrock_words <- prufrock_clean |>
  count(word, sort = TRUE)

# Combine all texts to find the more general trend of word frequency

## Bigram analysis or analysis by prepositioned words, codes sourced from https://www.youtube.com/watch?v=9T-hr3jinTw
combined_trigram <-
  rbind(portrait, swann, dalloway, prufrock, bliss)|>
  na.omit(portrait, swann, dalloway, prufrock, bliss) |>
  unnest_tokens(bigram, text, token = "ngrams", n = 3) |>
  separate(bigram, c("word1", "word2", "word3"), sep = " ") #|>
  #count(word1, word2, word3, sort = TRUE)

combined_bigram <-
  rbind(portrait, swann, dalloway, prufrock, bliss)|>
  na.omit(portrait, swann, dalloway, prufrock, bliss) |>
  unnest_tokens(bigram, text, token = "ngrams", n = 2) |>
  separate(bigram, c("word1", "word2"), sep = " ") #|>
  #count(word1, word2, sort = TRUE)

combined_text <- prufrock |>
  rbind(portrait, swann, dalloway, prufrock, bliss)|>
  na.omit(portrait, swann, dalloway, prufrock, bliss) |>
  unnest_tokens(word, text) |>
  anti_join(stop_words) |>
  filter(nchar(word) > 1) |>
  count(word, sort = TRUE)

#### Save data ####
write_csv(portrait_clean, "data/analysis_data/portrait_clean.csv")
write_csv(portrait_words, "data/analysis_data/portrait_words.csv")
write_csv(swann_words, "data/analysis_data/swann_words.csv")
write_csv(dalloway_words, "data/analysis_data/dalloway_words.csv")
write_csv(bliss_words, "data/analysis_data/bliss_words.csv")
write_csv(prufrock_words, "data/analysis_data/prufrock_words.csv")
write_csv(combined_text, "data/analysis_data/combined_text.csv")
write_csv(combined_bigram, "data/analysis_data/combined_bigram.csv")
write_csv(combined_trigram, "data/analysis_data/combined_trigram.csv")





