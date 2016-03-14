fn_extract_rooms_people <- function(xml_doc) {
  # returns a vector which contains bedroom and guest data
  x_path_exp <- strwrap("//div[@class = 'listing-tile ']/div[@class = 
                        'listing-tile__footer']/div/div[1]/div")
  
  # stringr::str_extract_all with simplify returns a matrix
  mat_br_people <- xpathSApply(xml_doc, x_path_exp , xmlValue) %>%
                    stringr::str_extract_all("[0-9]+", simplify = TRUE)                 
  return(mat_br_people)
}