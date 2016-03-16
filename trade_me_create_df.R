library(xml2)
library(dplyr)
library(XML)
library(stringr)

rm(list = ls())

## PPL using MAC, outside of MBIE envirnment does not need to run it.
if( Sys.info()['sysname'] == 'Windows' ){
  ## set up R environment ---------------------------------------------------
  source("P:/R/common.Rprofile")
}

options(stringsAsFactors = FALSE)

# the following extract various pieces from html / xml text
# DONE THIS
source("r_trade_me/fn_extract_page_ref.R")
source("r_trade_me/fn_extract_titles.R")
source("r_trade_me/fn_extract_locations.R")
source("r_trade_me/fn_extract_bedrooms.R")
source("r_trade_me/fn_extract_guests.R")
source("r_trade_me/fn_extract_price.R")

# the wraps the aforementioned functions together
source("r_trade_me/fn_wrapper_create_df.R")


# this is the url stub for reference:
# https://www.holidayhouses.co.nz/Browse/List.aspx?page=202

# We can just load in the file locally. 
lst_tm_html_text <- readRDS("outputs/trade_me_html_data.rds")

# We use the xml2 library first to convert from text to html 
lst_tm_html_parse <- lapply(lst_tm_html_text, xml2::read_html)

lst_df <- lapply(lst_tm_html_parse, fn_wrapper_create_df)

df_tm_results <- do.call(rbind, lst_df)

# create an area variable
df_tm_results <- df_tm_results %>% mutate(area =  gsub("^.*, ", "", location))

save(df_tm_results, file = "outputs/trade_me_df.rda")


# ========= SOME EXAMPLE QUERIES ==================================

# areas to be excluded
vct_exclusions <- c("Cook Islands", "Queensland", "Fiji", "Tonga", 
                    "Western Samoa", "Niue", "Norfolk Island", "New South Wales", 
                    "Victoria", "Vanuatu", NA)

# listings per area
df_tm_results %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(count = n()) %>% arrange(desc(count)) %>% as.data.frame()

# rooms per area
df_tm_results %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(num_rooms = sum(bedroom, na.rm = TRUE)) %>% 
  arrange(desc(num_rooms)) %>% as.data.frame()

# guests per area
df_tm_results %>% filter(!area %in% vct_exclusions) %>% group_by(area) %>% 
  summarise(num_guests = sum(guests, na.rm = TRUE)) %>% 
  arrange(desc(num_guests)) %>% as.data.frame()

# stuff you can't afford
df_tm_results %>%  filter(!area %in% vct_exclusions) %>% 
      filter(!is.na(price)) %>% filter(price > 2000) %>% arrange(desc(price))

# notes
# extraction location: "https://www.holidayhouses.co.nz/Browse/List.aspx?page="
# where pages = 1 to 203

