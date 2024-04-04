#### Preamble ####
# Purpose: Simulates datasets of word frequency
# Author: Quang Mai
# Date: 4 April 2024 
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: None
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(tibble)

#### Simulate data ####
set.seed(85) #ensure simulated data's reproducibility

# self-generate random words since R doesn't have a built-in dataset of random English words
random_words <- c("paper", "on", "five", "stream", "of", "consciousness", "authors", "and", "nine", "their", "most", "famous", "novels")
# generate a dataset of selected novels
novels <- c("A Portrait of the Artist as a Young Man", "Chamber Music", "Mrs Dalloway", "Jacob's Room", "Swann Way", "Bliss", "The Garden Party", "The Waste Land", "The Love Song of J. Alfred Prufrock")

simulated_data <-
  tibble(
    # Randomly select novels from the generated dataset of chosen novels where the unique words are capped at 12
    novel = sample(novels, 12, replace = TRUE, prob = NULL),  # Randomly select novels from the pre-defined novels dataset, repeatable since work can change
    # Randomly select words from the randomly generated dataset of words that are capped at 12
    word = sample(random_words, 12, replace = FALSE, prob = NULL),  # Randomly select words from the English words dataset, not repeated since this is the count of unique words
    #use 1 through 870 to represent each count of a word since 870 is the maximum number of a unique word appears out of all nine novels
    n = sample(1:870, 12, replace = TRUE))

# Print the simulated data 
print(simulated_data)

#### Data Validation ####

# Code referenced from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html

# Check that there are no more than 870 counts of a word #
simulated_data |>
  group_by(n) |>
  count() |>
  filter(n > n) |>
  sum() == 0

# Check that all n variables in the dataset are unique 
simulated_data$n  |> unique() |> length() == 12

# Check that there are exactly 9 chosen novels #
novels |> unique() |> length() == 9



    


