fn_get_b_a_bach_page_total <- function() {
  # we assume that there is always at least 1 page
  str_url <- "https://www.bookabach.co.nz/baches-and-holiday-homes/search/locale/new-zealand/page/1"
  
  # get the url and convert the result to "XMLInternalDocument"
  xml_doc <- xml2::read_html(str_url) %>% XML::xmlParse()
  
  # xpath expression to extract the total number of pages
  xp_tot_pages <- "//*[@id='js-pagination-container']/ul/li[@class = 'dots']/following-sibling::li[1]/a"
  
  # apply the x_path expression to extract the total
  int_tot_pages <- xpathSApply(xml_doc, xp_tot_pages, xmlValue) %>% as.numeric()
  
  # explicitly return
  return(int_tot_pages)
}