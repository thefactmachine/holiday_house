fn_extract_price <- function(xml_doc)  {
  # this gives price
  x_path_exp <- "//div[@class = 'listing-tile ']//div[@class = 'listing-tile__quote']/a/strong"
  vct_str_price <- xpathSApply(xml_doc, x_path_exp, xmlValue) %>% 
                  gsub("\\$|,", "", .) 

  # get a logical vector that indicates which of these is a number
  # if the vector element contains a a-z ====> this means its not a number
  # really needs a better test here to include punctuation
  vct_bln_is_number <- !grepl("[a-z]", tolower(vct_str_price))
  
  # if it is not a number then convert to an NA...then convert the string ..
  # vector to numbers
  vct_price <- ifelse(vct_bln_is_number, vct_str_price, NA) %>% as.numeric()
  
  
  return(vct_price)
}  