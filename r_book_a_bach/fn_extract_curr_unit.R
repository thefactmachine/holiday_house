fn_extract_curr_unit <- function(xml_doc) {
  # this gives currency units
  x_path_exp <- "//div[@class = 'listing-tile ']//div[@class = 'listing-tile__quote']/a"
  
  # vct_a_val typically gets: "from $250 NZD pn"
  vct_a_val <- xpathSApply(xml_doc, x_path_exp, xmlValue)
  
  # typically a list with 4 entries per element eg [1] "from" "$170" "NZD"  "pn"  
  lst_a_val <- str_split(vct_a_val, " ")
  
  #iterate through the list and return the 3rd element (i.e "NZD) 
  # if !exist(3rd Element) ==> NA returned
  vct_curr <- sapply(lst_a_val, function(x) x[3])
  return(vct_curr)
}

