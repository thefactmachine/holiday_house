fn_extract_bedrooms <- function(xml_doc) {
  # receives xml document and it returns a numeric vector of bedrooms
  xPath_exp <- strwrap("//div[@class = 'ListCard-content group']//
                div[@class = 'ListCard-details']/ul/li
                [@class = 'ListCard-bedrooms']/text()[2]")
  vct_num_bedrooms <- xpathSApply(xml_doc, xPath_exp, xmlValue) %>% 
                    gsub(" |&#13;\\n|\\+", "", .) %>% as.numeric()
  return(vct_num_bedrooms)
}