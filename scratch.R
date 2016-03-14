
library(xml2)
library(dplyr)
library(XML)
library(stringr)


rm(list = ls())
setwd("/Users/zurich/Documents/TEMP-FILES/mbie_scraping_holiday_homes")


source("r_book_a_bach/fn_get_b_a_bach_page_total.R")
source("r_book_a_bach/fn_extract_title.R")
source("r_book_a_bach/fn_extract_price_unit.R")
source("r_book_a_bach/fn_extract_price.R")
source("r_book_a_bach/fn_extract_curr_unit.R")
source("r_book_a_bach/fn_extract_sub_heading.R")
source("r_book_a_bach/fn_extract_rooms_people.R")
source("r_book_a_bach/fn_parse_web_page.R")

options(stringsAsFactors = FALSE)

str_base_url <- "https://www.bookabach.co.nz/baches-and-holiday-homes/search/locale/new-zealand/page/"
int_start_page <- 1


int_tot_pages <- fn_get_b_a_bach_page_total()

lst_html_results <- list()
for (i in int_start_page: int_tot_pages) {
  # create t he url
  str_url <- paste0(str_base_url,i)
  # create a title for the list
  str_list_title <- paste0("page_", as.character(i))
  # print a message to screeen
  message(paste0("reading ", str_url))
  # the xml2::read_html function provides a pointer to a c structure...so we convert to text.
  html_temp <- xml2::read_html(str_url) %>% as.character()
  lst_html_results[[str_list_title]] <- html_temp
}



save(lst_html_results, file = "book_a_bach_html_data.rda")



rm(list = ls())

load("book_a_bach_html_data.rda")
bln_DEBUG <- FALSE
xml_temp <- lst_html_results[['page_1']] %>% xmlParse()
aaa <- fn_parse_web_page(xml_temp)
aaa

lst_xml <- lapply(lst_html_results, xmlParse)


lst_df <- lapply(lst_xml, fn_parse_web_page)



df_result <- do.call(rbind, lst_df)


# create an area variable
df_result <- df_result %>% mutate(area =  gsub("^.*, ", "", loc))

dftest <- df_result %>% filter(!is.na(price))
nrow(dftest)

median(dftest$price)
max(dftest$price)

url_stub <- "https://www.bookabach.co.nz/baches-and-holiday-homes/view/"

head(paste0(url_stub, dftest$ref))







