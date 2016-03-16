fn_extract_titles <- function(a_html) {
  # receives xml document and it returns a character vector of titles
  lcl_xp <- paste0("//div[@class = 'ListCard-content group']//",
                        "div[@class = 'ListCard-heading']/p/a[@title]")
  
  lcl_xml_ns <- xml2::xml_find_all(a_html, lcl_xp)
  lcl_str_ref <- xml2::xml_text(lcl_xml_ns)
  return(lcl_str_ref)
}

