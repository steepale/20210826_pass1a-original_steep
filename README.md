# Processing of Metabolomics Datasets from the University of Michigan

This repo serves as a demonstration  of processing metabolomics datasets, or simply of data in general.

## Folders
-colors: 2 RGB files with craft color schemes--superior to R or RColorBrewer for heatmap visualization (author: Jun Li)  
-docs: relevant documents to aid scripted analyses (usually excel scripts)  
-functions: functions loaded into scripts for functionally programming  
-lit: relevant literature to analyses  
-ppt: powerpoints supporting analyses  
-scripts: scripts, almost always in R or R Markdown. To examine scripts and get a sense of the analysis, clone the repo and open the rendered HTML files locally  
-style: .css files to aid in script rendering from R Markdown to HTML  

## Nomenclature
-File are often named with 3 parts sperated by underscores:  
    -date as an identifier  
    -explanation  
    -author/editor  
    -(e.g. 20211213_all-ionpneg-pass1a-eda_steep.html) demonstrates an exploration ("eda") of "all" tissues in "ionpneg" datasets performed on 20211213 by Alec Steep  

## How to follow the analyses
Clone the repo and examine the rendered HTML files by date for a step-by-step analysis of processing these data. These data were not entirely processed; drift corrected data from an analogous dataset (PASS1C) did not agree because of data mishandling and improper drift correction.

A good example script to exmaine: 20211213_all-ionpneg-pass1a-eda_steep.html

## Withheld
Data and additional scripts withheld for brevity

## Contact
Alec Steep
alec.steep@gmail.com