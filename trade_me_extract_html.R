library(xml2)
library(dplyr)
library(XML)
library(stringr)
library(httr)

rm(list = ls())


## PPL using MAC, outside of MBIE envirnment does not need to run it.
if( Sys.info()['sysname'] == 'Windows' ){
  ## set up R environment ---------------------------------------------------
  source("P:/R/common.Rprofile")
}

# PURPOSE:
# the purpose of the is script is to iterate through the trade me web
# pages and to extract summary information about the various homes

# factors are out
options(stringsAsFactors = FALSE)

# define some stuff to use inside the while loop
lst_html_results <- list()
bln_html_pages_to_read <- TRUE
int_page_counter <- 1
str_url_stem <- "https://www.holidayhouses.co.nz/Browse/List.aspx?page="

# loop through summary web pages...stop the loop when there are no elements left
# on 7th March there were 203 web pages
while (bln_html_pages_to_read) {
  # compose URL
  str_url <- paste0(str_url_stem, as.character(int_page_counter))
  # read the current url into a temporary variable..uses library(httr)
  str_c_page <- content(GET(str_url), as = 'text')
  # convert the current page to html_object to find the number of elements
  html_c_page <- xml2::read_html(str_c_page)
  # number of houses (i.e. grid-item elements)...in current page
  int_num_elements <- xml_find_all(html_c_page, "//div[@class = 'ListCard-content group']") %>% length()
  if (int_num_elements > 0) {
    # print a helpful message to the screen
    message(paste0("reading page: ", str_url))
    # compose a string as a name for the list element eg "page_34"
    str_list_title <- paste0("page_", as.character(int_page_counter))
    # get the current html page and shove it into our list..need to convert to
    # character as lst_temp is just a pointer to a c object.
    lst_html_results[[str_list_title]] <- str_c_page
    int_page_counter <- int_page_counter + 1
  } # if
  else {
    bln_html_pages_to_read = FALSE
  } # else
} # while
# save what we have collected onto disk
saveRDS(lst_html_results, file = "outputs/trade_me_html_data.rds")
