#### Preamble ####
# Purpose: Clean the self-generated datasets 
# Author: Quang Mai
# Date: 30 March 2024 
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: Read four raw datasets containing the novel texts from five authors, namely `portrait.parquet`, `swann.parquet`. `dalloway.parquet`, `bliss.parquet` and `prufrock.parquet`

#### Workspace setup ####
library(tidyverse)
library(tidytext)
library(rmarkdown)
library(gutenbergr)
library(tm)
library(dplyr)
library(scales)
library(igraph)
library(widyr)
library(arrow)

#### Clean data ####
portrait <- read_parquet("data/raw_data/portrait.parquet")
swann <- read_parquet("data/raw_data/swann_way.parquet")
dalloway <- read_parquet("data/raw_data/mrs_dalloway.parquet")
bliss <- read_parquet("data/raw_data/bliss.parquet")
prufrock <- read_parquet("data/raw_data/prufrock.parquet")


# Tokenize the words from the text, breaking the text down into individual words to insert them into individual datasets
# Codes referenced from https://medium.com/the-data-nudge/nlp-basics-exploring-word-frequency-with-the-tidytext-r-package-ac35a6d805f4

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
  count(word, sort = TRUE) |>
  filter(str_detect(word, "[:alpha:]")) |> # Remove rows where the word column does not contain any alphabetical characters.
  distinct() # Return distinct words only

swann_words <- swann_clean |>
  count(word, sort = TRUE) |>
  filter(str_detect(word, "[:alpha:]")) |>
  distinct()

dalloway_words <- dalloway_clean |>
  count(word, sort = TRUE) |>
  filter(str_detect(word, "[:alpha:]")) |> 
  distinct()

bliss_words <- bliss_clean |>
  count(word, sort = TRUE) |>
  filter(str_detect(word, "[:alpha:]")) |> 
  distinct()

prufrock_words <- prufrock_clean |>
  count(word, sort = TRUE) |>
  filter(str_detect(word, "[:alpha:]")) |> 
  distinct()

# Combine all texts to find the more general trend of word frequency and sentiment value
combined_text <- 
  rbind(portrait, swann, dalloway, prufrock, bliss)|>
  na.omit(portrait, swann, dalloway, prufrock, bliss) |>
  unnest_tokens(word, text) |>
  anti_join(stop_words) |>
  filter(str_detect(word, "[:alpha:]")) 

#### Save data ####
write_parquet(portrait_clean, "data/analysis_data/portrait_clean.parquet")
write_parquet(portrait_words, "data/analysis_data/portrait_words.parquet")
write_parquet(swann_words, "data/analysis_data/swann_words.parquet")
write_parquet(dalloway_words, "data/analysis_data/dalloway_words.parquet")
write_parquet(bliss_words, "data/analysis_data/bliss_words.parquet")
write_parquet(prufrock_words, "data/analysis_data/prufrock_words.parquet")
write_parquet(combined_text, "data/analysis_data/combined_text.parquet")





