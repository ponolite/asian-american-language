#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(tidytext)
library(rmarkdown)
library(gutenbergr)
library(tm)
library(dplyr)
library(ggplot2)


# Collect stream-of-conscious authors main texts:

all_books <- gutenberg_metadata

joyce_books <- all_books %>%
  filter(str_detect(author, 'Joyce, James'))

woolf_books <- all_books %>%
  filter(str_detect(author, 'Woolf, Virginia'))

dostoevsky_books <- all_books %>%
  filter(str_detect(author, 'Dostoyevsky, Fyodor'))

proust_books <- all_books %>%
  filter(str_detect(author, 'Proust, Marcel'))

combined_books <- rbind(joyce_books, woolf_books, dostoevsky_books, proust_books)


# Download the text of the most stream-of-consciousness works of each author:

portrait <- gutenberg_download(c('4217')) |>
  mutate(book = ifelse(gutenberg_id == 4217, "A Portrait of the Artist as a Young Man", "NA")) |>
  slice(-(1:20))

swann_way <- gutenberg_download(c('7178')) |>
  mutate(book = ifelse(gutenberg_id == 7178, "Swann's Way", "NA")) |>
  slice(-(1:33))

mrs_dalloway <- gutenberg_download(c('63107')) |>
  mutate(book = ifelse(gutenberg_id == 63107, "Mrs Dalloway", "NA")) |>
  slice(-(1:25))

notes_underground <- gutenberg_download(c('600')) |>
  mutate(book = ifelse(gutenberg_id == 600, "Notes from the Underground", "NA")) |>
  slice(-(1:57))

#### Save data ####
write_csv(portrait, "data/raw_data/portrait.csv") 
write_csv(swann_way, "data/raw_data/swann_way.csv") 
write_csv(mrs_dalloway, "data/raw_data/mrs_dalloway.csv") 
write_csv(notes_underground, "data/raw_data/notes_underground.csv") 
write_csv(all_books, "data/raw_data/all_books.csv") 
write_csv(combined_books, "data/raw_data/combined_books.csv") 



