fn_extract_locations <- function(xml_doc) {
  # receives xml document and it returns a character vector of locations
  xPath_exp <- strwrap("//div[@class = 'ListCard-content group']//
                       div[@class = 'ListCard-location']/a")
  vct_locations <- xpathSApply(xml_doc, xPath_exp, xmlValue) %>% 
                    ifelse(. == "", NA, .)
  return(vct_locations)
}