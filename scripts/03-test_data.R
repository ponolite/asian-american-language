#### Preamble ####
# Purpose: Tests for the six cleaned datasets to make sure that they can be analyzed
# Author: Quang Mai
# Date: 21 April 2024
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: combined_text.parquet, portrait_words.parquet, swann_words.parquet, dalloway_words.parquet, bliss_words.parquet, prufrock_words.parquet, combined_text.parquet
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(arrow)

portrait_words <- read_parquet(here::here("data/analysis_data/portrait_words.parquet"))
swann_words <- read_parquet(here::here("data/analysis_data/swann_words.parquet"))
dalloway_words <- read_parquet(here::here("data/analysis_data/dalloway_words.parquet"))
bliss_words <- read_parquet(here::here("data/analysis_data/bliss_words.parquet"))
prufrock_words <- read_parquet(here::here("data/analysis_data/prufrock_words.parquet"))
combined_text <- read_parquet(here::here("data/analysis_data/combined_text.parquet"))


#### Test data ####
# check that there are nine unique ids to represent 9 books
length(unique(combined_text$gutenberg_id)) == 9
length(unique(combined_text$book)) == 9

# check that there are five unique author names to represent five authors
length(unique(combined_text$author)) == 5

# check that the number of words in all nine texts is only from 1 to 167,516
length(combined_text$word) == 167516

# check that the number of unique words in Mansfield's texts is 7829
length(bliss_words$word) == 7829

# check that the number of unique words in Proust's texts is 12203
length(swann_words$word) == 12203

# check that the number of unique words in Eliot's texts is 2350
length(prufrock_words$word) == 2350

# check that the number of unique words in Joyce's texts is 8927
length(portrait_words$word) == 8927

# check that the number of unique words in Woolf's texts is 7036
length(dalloway_words$word) == 7036

# check that the minimum frequency out of all unique words in all texts is 1 
min(bliss_words$n) >= 1 #Mansfield
min(prufrock_words$n) >= 1 #Eliot
min(portrait_words$n) >= 1 #Joyce
min(swann_words$n) >= 1 #Proust
min(dalloway_words$n) >= 1 #Woolf

# check that the maximum frequency out of all unique words in all texts is 602

max(max(bliss_words$n), 
    max(prufrock_words$n), 
    max(portrait_words$n), 
    max(dalloway_words$n), 
    max(swann_words$n)) == 602
