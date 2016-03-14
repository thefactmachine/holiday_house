fn_extract_title <- function(xml_doc) {
  vct_titles <- xpathSApply(xml_doc, 
                            "//div[@class = 'listing-tile ']//h2/a", 
                            xmlValue) 
   return(vct_titles)
}