library(xml2)
library(dplyr)
library(XML)
library(stringr)

rm(list = ls())

setwd("/Volumes/DTLPLUS 1/holiday_houses")
#setwd("/Users/zurich/Documents/TEMP-FILES/mbie_scraping_holiday_homes")

## PPL using MAC, outside of MBIE envirnment does not need to run it.
if( Sys.info()['sysname'] == 'Windows' ){
  ## set up R environment ---------------------------------------------------
  source("P:/R/common.Rprofile")
}

# PURPOSE:
# the purpose of the is script is to iterate through book-a-bach web
# pages and to extract summary information about the various homes

# factors are out
options(stringsAsFactors = FALSE)

# define base_url. Here is a hack to put it on two lines.
str_base_url <- paste0("https://www.bookabach.co.nz/baches-and-",
                        "holiday-homes/search/locale/new-zealand/page/")
# assume that there is at least 1 page
int_start_page <- 1
# this function determines how many summary pages there are
source("r_book_a_bach/fn_get_b_a_bach_page_total.R")
int_tot_pages <- fn_get_b_a_bach_page_total()

# create a blank list..this gets populated in the for loop
lst_html_results <- list()

# iterate from page_1 to page_n
for (i in int_start_page: int_tot_pages) {
  # create t he url
  str_url <- paste0(str_base_url,i)
  # create a title for the list
  str_list_title <- paste0("page_", as.character(i))
  # print a message to screen - inform the user what html page we are up to
  message(paste0("reading ", str_url))
  # the xml2::read_html function provides a pointer to a 'c' structure
  #...so we convert to text..so we can incorporate into a list
  html_temp <- xml2::read_html(str_url) %>% as.character()
  lst_html_results[[str_list_title]] <- html_temp
}

save(lst_html_results, file = "outputs/book_a_bach_html_data.rda")

