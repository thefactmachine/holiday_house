fn_extract_guests <- function(xml_doc) {
  # receives xml document and it returns a numeric vector of guests
  xPath_exp <- strwrap("//div[@class = 'ListCard-content group']//
                div[@class = 'ListCard-details']/ul/li
                [@class = 'ListCard-guests']/text()[2]")

  vct_num_guests <- xpathSApply(xml_doc, xPath_exp, xmlValue) %>% 
                  gsub(" |&#13;\\n|\\+", "", .) %>% as.numeric()
  return(vct_num_guests)
}