fn_extract_sub_heading <- function(xml_doc) {
  # from the html document, this function extracts a list of 
  # sub-headings. The length of the list is equal to the number
  # of elements (i.e houses on the web page).  Each element in the list
  # contains 3 sentences. 
  # EXAMPLE:
  # This is extracted and then split into 3 elements:
  # "Chalet | Ohakune, Ohakune & Surrounds | #26092"
  
  x_path_exp <- "//div[@class = 'listing-tile ']//div[@class = 'col-xs-12']/p"
  
  lst_sub_title <- xpathSApply(xml_doc, x_path_exp, xmlValue) %>% 
                    strsplit(" \\| ") 
  
  return(lst_sub_title)
  
}