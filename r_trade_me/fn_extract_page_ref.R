fn_extract_page_ref <- function(xml_doc) {
  # receives xml document and it returns a character vector of Urls
  xPath_exp <- strwrap("//div[@class = 'ListCard-content group']
                       //div[@class = 'ListCard-heading']/p/a[@href]")
  vct_page_urls <- xpathSApply(xml_doc , xPath_exp, xmlGetAttr, "href") %>% 
    paste0("https://www.holidayhouses.co.nz", .) 
  return(vct_page_urls)
}
