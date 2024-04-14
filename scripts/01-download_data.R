#### Preamble ####
# Purpose: Downloads and saves the novel texts from Project Gutenberg (https://www.gutenberg.org_
# Author: Quang Mai
# Date: 29 March 2024 
# Contact: quangpono@gmail.com
# License: MIT
# Pre-requisites: Install and load packages tidytext and gutenbergr

#### Workspace setup ####
library(tidyverse)
library(tidytext)
library(rmarkdown)
library(gutenbergr)
library(tm)
library(dplyr)


# Collect stream-of-conscious authors main texts
# Codes referenced from https://medium.com/the-data-nudge/nlp-basics-exploring-word-frequency-with-the-tidytext-r-package-ac35a6d805f4

all_books <- gutenberg_metadata

joyce_books <- all_books %>%
  filter(str_detect(author, 'Joyce, James'))

woolf_books <- all_books %>%
  filter(str_detect(author, 'Woolf, Virginia'))

mansfield_books <- all_books %>%
  filter(str_detect(author, 'Mansfield, Katherine'))

proust_books <- all_books %>%
  filter(str_detect(author, 'Proust, Marcel'))

ts_books <- all_books %>%
  filter(str_detect(author, 'Eliot, T. S.'))


combined_books <- rbind(joyce_books, woolf_books, dostoevsky_books, proust_books, ts_books, mansfield_books)

# Download the more famous stream-of-consciousness work of each author:

portrait <- gutenberg_download(c('4217', '2817')) |>
  mutate(book = ifelse(gutenberg_id == 4217, "A Portrait of the Artist as a Young Man", "Chamber Music")) |>
  mutate(author = ifelse(gutenberg_id == 4217, "James Joyce", "James Joyce")) |>
  slice(-(1:20))

swann_way <- gutenberg_download(c('7178')) |>
  mutate(book = ifelse(gutenberg_id == 7178, "Swann's Way", "NA")) |>
  mutate(author = ifelse(gutenberg_id == 7178, "Marcel Proust", "Marcel Proust")) |>
  slice(-(1:33))

mrs_dalloway <- gutenberg_download(c('63107', '5670')) |>
  mutate(book = ifelse(gutenberg_id == 63107, "Mrs Dalloway", "Jacob's Room")) |>
  mutate(author = ifelse(gutenberg_id == 63107, "Virigina Woolf", "Virginia Woolf")) |>
  slice(-(1:25))

prufrock <- gutenberg_download(c('1321', '1459')) |>
  mutate(book = ifelse(gutenberg_id == 1321, "The Waste Land", "Prufrock and Other Observations")) |>
  mutate(author = ifelse(gutenberg_id == 63107, "T.S. Eliot", "T.S. Eliot")) |>
  slice(-(1:35))

bliss <- gutenberg_download(c('44385', '1429')) |>
  mutate(book = ifelse(gutenberg_id == 1321, "Bliss", "The Garden Party")) |>
  mutate(author = ifelse(gutenberg_id == 63107, "Katherine Mansfield", "Katherine Mansfield")) |>
  slice(-(1:34))

#### Save data ####
write_csv(portrait, "data/raw_data/portrait.csv") 
write_csv(swann_way, "data/raw_data/swann_way.csv") 
write_csv(mrs_dalloway, "data/raw_data/mrs_dalloway.csv") 
write_csv(prufrock, "data/raw_data/prufrock.csv") 
write_csv(bliss, "data/raw_data/bliss.csv") 
write_csv(all_books, "data/raw_data/all_books.csv") 
write_csv(combined_books, "data/raw_data/combined_books.csv") 



