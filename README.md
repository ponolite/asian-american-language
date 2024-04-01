# The Linguistic Landscape of Stream-of-Consciousness Literature: Exploring Mental Health Themes in the Works of Joyce, Woolf, Proust, and Dostoevsky"

## Overview

This repo provides students with a foundation to understand the most repeated and dominant language used by transnational stream-of-consciousness authors-namely, James Joyce, Virginia Woolf, Marcel Proust and Fyodor Dostoevsky-to garner more information on their mental landscapes. Through the analysis of these authors' most famous works, we can gain insights into the portrayal of mental health themes such as anxiety, depression, trauma, and existential angst within the stream-of-consciousness genre. This exploration helps us understand the shared linguistic patterns of the stream-of-consciousness genre and offers a glimpse into the authors' mental states, shedding light on themes of self-identity and others.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Project Gutenberg.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Data Extraction

I generated my own dataset using the `gutenbergr` and `tidytext` packages, leveraging existing literature from Project Gutenberg, a volunteer archive to digitize cultural and literary works. Here is the link to the archive: https://www.gutenberg.org. To extract different novels into datasets, I first tokenize, or break the novels down into smaller chunks called tokens or words. Then, using the `tidytext`'s "stop_words" dataset, I exclude stop words like 'a', 'the', etc., thus enhancing the validity of my own dataset.

## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatHorse and the entire chat history is available in inputs/llms/usage.txt.
