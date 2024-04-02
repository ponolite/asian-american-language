# The Linguistic Landscape of Stream-of-Consciousness Literature: Exploring Word Frequency and Mental Health Themes in the Works of Joyce, Woolf, Proust, and Dostoevsky from Project Gutenberg

## Overview

This project focuses on understanding the language used by renowned, transnational stream of consciousness authors James Joyce, Virginia Woolf, Marcel Proust, and Fyodor Dostoevsky. By analyzing the word frequency of their famous works-respectively, A Portrait of the Artist as a Young Man, Mrs Dalloway, Swann Way and Notes from Underground-I explore mental health themes like anxiety, depression, trauma, and existential angst. Through word frequency analysis, I aim to uncover shared linguistic patterns and gain insights into the authors' mental states, offering a glimpse into themes of self-identity and existential contemplation

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Project Gutenberg.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Data Extraction

I generated my own dataset using the `gutenbergr` and `tidytext` packages, leveraging existing literature from Project Gutenberg, a volunteer archive to digitize cultural and literary works. Here is the link to the archive: https://www.gutenberg.org. To extract different novels into datasets, I first tokenize, or break the novels which I downloaded from Project Gutenberg into smaller chunks called tokens or words. Then, using the `tidytext`'s "stop_words" dataset, I exclude stop words like 'a', 'the', etc., thus enhancing the validity of each of the novel's dataset.

## Statement on LLM usage

Aspects of the code were written with the help of the autocomplete tool, ChatGPT. ChatGPT was mainly used to refine the paper's writing and small lines of codes. The entire chat history is available in inputs/LLM/usage.txt
