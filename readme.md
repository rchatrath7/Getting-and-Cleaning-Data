---
title: "ReadMe"
output: html_document
---

## Getting and Cleaning Data Final Project
This is the readme for the final project for the Coursera course, getting and cleaning data. The script `run_analysis_r.R` does the following: 

* Downloads datasets 
* Merges the training and testing sets into one dataset
* Gathers features and activity labels, removing unwanted variables 
* Trims the dataset to only incede the `mean` and `std` of each feature
* Assigns useful names to the columns of the dataset 

The end result is stored in `tidy.txt` 
