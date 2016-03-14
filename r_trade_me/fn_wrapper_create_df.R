fn_wrapper_create_df <- function(xml_node) {
  # receives a single xml_node that contains about 50 graphic elements
  # parses these graphic elements and extracts pieces into vectors
  # vectors are then assembled into a dataframe
  vct_refs <- fn_extract_page_ref(xml_node)
  vct_titles <- fn_extract_titles(xml_node)
  vct_locs <- fn_extract_locations(xml_node)
  vct_num_bedrooms <- fn_extract_bedrooms(xml_node)
  vct_num_guests <- fn_extract_guests(xml_node)
  vct_price <- fn_extract_price(xml_node)
  
  # assemble these vectors into a data.frame and return
  df_return <- data.frame(
      ref = vct_refs,
      title = vct_titles,
      location = vct_locs,
      bedroom = vct_num_bedrooms,
      guests = vct_num_guests,
      price = vct_price
  )
 return(df_return)
}