fn_extract_locations <- function(a_html) {
  # receives xml document and it returns a character vector of locations
  lcl_xp <- paste0("//div[@class = 'ListCard-content group']//",
                       "div[@class = 'ListCard-location']/a")
  
  lcl_xml_ns <- xml2::xml_find_all(a_html, lcl_xp)
  lcl_str_ref <- xml2::xml_text(lcl_xml_ns) %>% ifelse(. == "", NA, .)
  return(lcl_str_ref)

}

