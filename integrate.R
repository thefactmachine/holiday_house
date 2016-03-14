library(xml2)
library(dplyr)
library(XML)
rm(list = ls())

options(stringsAsFactors = FALSE)
setwd("/Users/zurich/Documents/TEMP-FILES/mbie_scraping_holiday_homes")


source("r_trade_me/fn_collect_web_pages.R")
source("r_trade_me/fn_extract_page_ref.R")
source("r_trade_me/fn_extract_titles.R")
source("r_trade_me/fn_extract_locations.R")
source("r_trade_me/fn_extract_bedrooms.R")
source("r_trade_me/fn_extract_guests.R")
source("r_trade_me/fn_extract_price.R")
source("r_functions/fn_wrapper_create_df.R")




# harvest all web pages into a list of html docs
# the function also saves this file as "lst_html.rda"

lst_html_results <- fn_collect_web_pages()

# We can just load in the file locally. 
load("lst_html.rda")

# extract the <body> element and convert html to xml
lst_xml <- lapply(lst_html_results, function(x) 
  xml2::xml_find_one(x, "/html/body") %>% XML::xmlParse())

# we have our xml nodes, now we turn them into a list of data.frames
lst_df <- lapply(lst_xml, function(a) fn_wrapper_create_df(a))


# convert the list of data.frames to one nice data.frame
df_result <- do.call(rbind, lst_df)
# make sure the row.names are not lost
df_result$source <- row.names(df_result)

# some duplicates caused by the first page displaying a banner
df_result <- df_result %>% dplyr::distinct() %>% as.data.frame()


# create an area variable
df_result <- df_result %>% mutate(area =  gsub("^.*, ", "", location))

# ========= SOME EXAMPLE QUERIES ==================================

# areas to be excluded
vct_exclusions <- c("Cook Islands", "Queensland", "Fiji", "Tonga", 
                    "Western Samoa", "Niue", "Norfolk Island", "New South Wales", 
                    "Victoria", "Vanuatu", NA)

# listings per area
df_result %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(count = n()) %>% arrange(desc(count)) %>% as.data.frame()

# rooms per area
df_result %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(num_rooms = sum(bedroom, na.rm = TRUE)) %>% 
  arrange(desc(num_rooms)) %>% as.data.frame()

# guests per area
df_result %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(num_guests = sum(guests, na.rm = TRUE)) %>% 
  arrange(desc(num_guests)) %>% as.data.frame()

# stuff you can't afford
df_result %>%  filter(!area %in% vct_exclusions) %>% 
      filter(!is.na(price)) %>% filter(price > 2000) %>% arrange(desc(price))

# notes
# extraction location: "https://www.holidayhouses.co.nz/Browse/List.aspx?page="
# where pages = 1 to 203

