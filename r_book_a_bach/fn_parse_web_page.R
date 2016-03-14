fn_parse_web_page <- function(xml_web_page) {
  # this function receives a web_page and then
  # extracts the important bits and then returns
  # the results as a data.frame
  
  vct_title <- fn_extract_title(xml_web_page)
  vct_price_u <- fn_extract_price_unit(xml_web_page)
  vct_price <- fn_extract_price(xml_web_page)
  vct_curr_u <- fn_extract_curr_unit(xml_web_page)
  
  # this returns a list of three elements
  lst_sub_h <- fn_extract_sub_heading(xml_web_page)
  vct_type <- sapply(lst_sub_h, function(x) x[1])
  vct_loc <- sapply(lst_sub_h, function(x) x[2])
  vct_raw_id <- sapply(lst_sub_h, function(x) x[3]) %>% gsub("#", "", .)
  
  # returns a N * 2 matrix col1 = Br; col2 = people
  mat_br_people <- fn_extract_rooms_people(xml_web_page)
  vct_br <- mat_br_people[, 1] %>% as.numeric()
  vct_people <- mat_br_people[, 2] %>% as.numeric()
  
  # use the following to debug the program
  if(bln_DEBUG) {
    print(paste("reference ", length(vct_raw_id)))
    print(paste("title ", length(vct_title)))
    print(paste("locaton ", length(vct_loc)))
    print(paste("bedroom ", length(vct_br)))
    print(paste("guests ", length(vct_people)))
    print(paste("price ", length(vct_price)))
    print(paste("unit ", length(vct_price_u)))
    print(paste("curr ", length(vct_curr_u)))
  }
  
  # assempble all the vectors into a data.frame
  df_data <- data.frame(ref = vct_raw_id, 
                        title = vct_title, 
                        type = vct_type,
                        loc = vct_loc,
                        bedrooms = vct_br,
                        guests = vct_people,
                        price = vct_price,
                        unit = vct_price_u,
                        curr = vct_curr_u
  )
  return(df_data)
}