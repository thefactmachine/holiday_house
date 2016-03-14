fn_collect_web_pages <- function() {
  # iterate through some trademe pages and store the html into a list
  
  # define some stuff to use inside the while loop
  lst_html_results <- list()
  bln_html_pages_to_read <- TRUE
  int_page_counter <- 1
  str_url_stem <- "https://www.holidayhouses.co.nz/Browse/List.aspx?page="
  
  # loop through summary web pages...stop the loop when there are no elements left
  # on 7th March there were 203 web pages
  while (bln_html_pages_to_read) {
    # compose URL
    str_url <- paste0(str_url_stem, as.character(int_page_counter))
    # read the current url into a temporary variable
    lst_temp <- xml2::read_html(str_url)
    # number of houses (i.e. grid-item elements)...in current page
    int_num_elements <- xml_find_all(lst_temp, "//div[@class = 'ListCard-content group']") %>% length()
    if (int_num_elements > 0) {
      # print a helpful message to the screen
      print(paste0("reading page: ", str_url))
      # compose a string as a name for the list element eg "page_34"
      str_list_title <- paste0("page_", as.character(int_page_counter))
      # get the current html page and shove it into our list
      lst_html_results[[str_list_title]] <- lst_temp
      int_page_counter <- int_page_counter + 1
    } # if
    else {
      bln_html_pages_to_read = FALSE
    } # else
  } # while
  # save what we have collected onto disk
  save(lst_html_results, file = "lst_html.rda")
  return(lst_html_results)
} # function