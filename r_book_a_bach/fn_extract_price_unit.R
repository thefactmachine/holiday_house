fn_extract_price_unit <- function(xml_doc) {
  x_path_exp <- strwrap("//div[@class = 'listing-tile ']
                //div[@class = 'listing-tile__quote']/a")
  vct_price_unit <- xpathSApply(xml_doc, x_path_exp, xmlValue) %>% 
                    str_extract("\\w+$")
  return(vct_price_unit)
} 
