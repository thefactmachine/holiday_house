fn_extract_price <- function(a_html) {
  lcl_xp <- paste0("//div[@class = 'ListCard-content group']",
                      "//div[@class = 'ListCard-heading']",
                      "/p[@class = 'ListCard-price']")
  
  lcl_xml_ns <- xml2::xml_find_all(a_html, lcl_xp)
  lcl_str_ref <- xml2::xml_text(lcl_xml_ns) %>% 
    gsub(" |\\n|\\r|From|\\$", "", .) %>% 
    as.numeric()
  
  return(lcl_str_ref)
}



