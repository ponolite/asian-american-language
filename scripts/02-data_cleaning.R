#### Preamble ####
# Purpose: Clean the self-generated datasets 
# Author: Quang Mai
# Date: 30 March 2024 
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: Read four raw datasets containing the four novels

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
notes <- read_csv("data/raw_data/notes_underground.csv")

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

notes_tokenized <- notes |>
  na.omit(notes) |>
  unnest_tokens(word, text)

# Exclude stop word using the tidytext stop_words dataset, also, use anti_join() to specify the name of the dataset with words that need to be excluded
data(stop_words)

portrait_clean <- portrait_tokenized |>
  anti_join(stop_words)

swann_clean <- swann_tokenized |>
  anti_join(stop_words)

dalloway_clean <- dalloway_tokenized |>
  anti_join(stop_words)

notes_clean <- notes_tokenized |>
  anti_join(stop_words)

# Use count() to quickly get the count of the most frequently used words
portrait_words <- portrait_clean |>
  count(word, sort = TRUE)

swann_words <- swann_clean |>
  count(word, sort = TRUE)

dalloway_words <- dalloway_clean |>
  count(word, sort = TRUE)

notes_words <- notes_clean |>
  count(word, sort = TRUE)


#### Save data ####
write_csv(portrait_words, "data/analysis_data/portrait_words.csv")
write_csv(swann_words, "data/analysis_data/swann_words.csv")
write_csv(dalloway_words, "data/analysis_data/dalloway_words.csv")
write_csv(notes_words, "data/analysis_data/notes_words.csv")
