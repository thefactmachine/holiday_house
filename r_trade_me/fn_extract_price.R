fn_extract_price <- function(xml_doc) {
  xPath_exp <-  strwrap("//div[@class = 'ListCard-content group']
                        //div[@class = 'ListCard-heading']
                        /p[@class = 'ListCard-price']")
   vct_amount <- xpathSApply(xml_doc, xPath_exp, xmlValue) %>% 
    gsub(" |\\n|\\r|From|\\$", "", .) %>% as.numeric()
  return(vct_amount)
}
