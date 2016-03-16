library(xml2)
library(dplyr)
library(XML)
library(stringr)
library(codetools)

rm(list = ls())

## PPL using MAC, outside of MBIE envirnment does not need to run it.
if( Sys.info()['sysname'] == 'Windows' ){
  ## set up R environment ---------------------------------------------------
  source("P:/R/common.Rprofile")
}

# PURPOSE:
# the purpose of this script is to iterate through a list
# of html files (previously saved) and then convert each of
# these files into a data.frame.  This will create a list of 
# data.frames.  We combine this list of data.frames into a single
# consolidated data.frame.  We then save this to an rda file

# factors are out
options(stringsAsFactors = FALSE)

setwd("/Volumes/DTLPLUS 1/holiday_houses")

# each of the following extracts a little
# bit of information from an html page
source("r_book_a_bach/fn_extract_title.R")
source("r_book_a_bach/fn_extract_price_unit.R")
source("r_book_a_bach/fn_extract_price.R")
source("r_book_a_bach/fn_extract_curr_unit.R")
source("r_book_a_bach/fn_extract_sub_heading.R")
source("r_book_a_bach/fn_extract_rooms_people.R")

# this one wraps the aforementioend functions together
source("r_book_a_bach/fn_parse_web_page.R")

# this will load in "lst_html_results"
load("outputs/book_a_bach_html_data.rda")

# used within: fn_parse_web_page()
bln_DEBUG <- FALSE

# convert the html documents to xml objects
lst_xml <- lapply(lst_html_results, xmlParse)

# apply the function to each list element..this is 
lst_df <- lapply(lst_xml, fn_parse_web_page)

# club the data.frames together
df_bab_result <- do.call(rbind, lst_df)

# create an area variable....
df_bab_result <- df_bab_result %>% mutate(area =  gsub("^.*, ", "", loc))

# save the data.frame as a binary object.
save(df_bab_result, file = "outputs/book_a_bach_df.rda")