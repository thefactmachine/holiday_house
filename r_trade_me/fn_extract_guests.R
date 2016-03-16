fn_extract_guests <- function(a_html) {
  # receives xml document and it returns a numeric vector of guests
  lcl_xp <- paste0("//div[@class = 'ListCard-content group']//",
                "div[@class = 'ListCard-details']/ul/li",
                "[@class = 'ListCard-guests']/text()[2]")
  
  lcl_xml_ns <- xml2::xml_find_all(a_html, lcl_xp)
  lcl_str_ref <- xml2::xml_text(lcl_xml_ns) %>%
                  gsub(" |&#13;\\n|\\+", "", .) %>%
                  as.numeric()
  
  return(lcl_str_ref)
}

