fn_extract_titles <- function(xml_doc) {
  # receives xml document and it returns a character vector of titles
  xPath_exp <- strwrap("//div[@class = 'ListCard-content group']//
                        div[@class = 'ListCard-heading']/p/a[@title]")
  vct_titles <- xpathSApply(xml_doc , xPath_exp, xmlGetAttr, "title")
  return(vct_titles)
}
