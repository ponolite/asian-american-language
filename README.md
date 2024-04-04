# Stream of Consciousness Literature: A 'Joyceless' Linguistic Landscape 
### Exploring Word Frequency, Sentiment Value and Mental Health Themes in the Works of Joyce, Woolf, Proust, Mansfield and Eliot from Project Gutenberg

## Overview

This repo focuses on understanding the language used by renowned stream of consciousness authors James Joyce, Virginia Woolf, Marcel Proust, Katherine Mansfield and T.S Eliot in the modernist era of literature. By analyzing the word frequency and sentiments of their famous works-respectively, A Portrait of the Artist as a Young Man, Chamber Music, Mrs Dalloway, Jacob's Room, Swann Way, Bliss, The Garden Party, The Waste Land and The Love Song of J. Alfred Prufrock-I explore mental health themes like anxiety, depression, trauma, and existential angst. Through word frequency and sentiment value analysis, I aim to uncover shared linguistic patterns and gain insights into the authors' mental states, offering a glimpse into the socio-political state of Western literature and society from late 19th century to mid-20th century.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Project Gutenberg.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Data Extraction

I generated my own datasets using the `gutenbergr` and `tidytext` packages, leveraging existing literature from Project Gutenberg, a volunteer archive that digitizes cultural and literary works. Here is the link to the archive: https://www.gutenberg.org. To extract different novels into datasets, I first tokenized, or broke the novels which I had downloaded from Project Gutenberg into smaller chunks called tokens or words. Then, using the `tidytext`'s "stop_words" dataset, I exclude stop words like 'a', 'the', etc., thus enhancing the validity of each novel's dataset.

## Statement on LLM usage

Aspects of the paper were written with the help of the generative artificial intelligence tool, ChatGPT. ChatGPT was mainly used to refine the paper's codes. The entire chat history is available in inputs/LLM/usage.txt
