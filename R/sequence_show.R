#' Show duplicate sequences in a datatable
#' @param data data.frame to with possible duplicates
#' @param meta_cols meta data to retain. Uses tidy-select
#' @param test_cols columns of data to test for duplicates. Uses tidy-select
#' @param ... Arguments to sequence_extract_all
#' @details Highlights different sets of duplicates in a datatable. Adds extra columns before each tested column to show each duplicate set. Columns headers have the format number.number.number, where the first number refers to the number of the tested column, the second refers to the sequence length and the third is a unique identifier for each sequence length.
#' @examples 
#' data(kp2014)
#' sequence_show(kp2014, meta_cols = 1:3, test_cols = starts_with("Theridion"))
#' @importFrom dplyr is.grouped_df select mutate full_join bind_cols arrange rename_with %>%
#' @importFrom tidyr pivot_longer pivot_wider
#' @importFrom tidyselect peek_vars
#' @importFrom DT datatable formatStyle styleEqual
#' @importFrom grDevices hcl.colors
#' @importFrom rlang .data
#' @export
sequence_show <- function(data, meta_cols, test_cols, ...){
  if(is.grouped_df(data)){
    stop("Cannot use grouped data - please use ungroup() first")
  }
  #combine test data
  test_data <- data %>% 
    select({{test_cols}}) %>% 
    unlist()
  
  found_sequences <- sequence_find_all(test_data, ...) %>% 
    mutate(id = paste(.data$length, .data$duplicate_no, sep = "."), .before = 1) %>% 
    select(.data$id, .data$pos1, .data$pos2) %>% 
    pivot_longer(-.data$id, names_to = "name", values_to = "pos") %>% 
    mutate(col = ((.data$pos - 1) %/% nrow(data)) + 1, 
           row = ((.data$pos - 1) %% nrow(data)) + 1) %>% 
    mutate(col_id = paste(.data$col, .data$id, sep = ".")) %>% 
    select(-.data$name, -.data$pos, -.data$col)
  
  found_sequences_wide <- found_sequences %>% 
    pivot_wider(names_from = "col_id", values_from = "id") %>% 
    full_join(tibble(row = 1:nrow(data)), by = "row") %>% 
    arrange(.data$row) %>% 
    select(-.data$row) 
 
  found_sequences_wide_data <- data %>% 
    select({{test_cols}}) %>% 
    rename_with(~paste(1:length(.x), .x, sep = ".")) %>%
    bind_cols(found_sequences_wide) %>%  
    select(sort(peek_vars()))
  
  result <- data %>% 
    select({{meta_cols}}) %>% 
    bind_cols(
      found_sequences_wide_data
    )

  datatable(data = result, 
            options = list(autoWidth = TRUE, pageLength = 100)) %>% 
    formatStyle(
      names(found_sequences_wide),
      backgroundColor = styleEqual(
        unique(found_sequences$id), hcl.colors(length(unique(found_sequences$id)))
      )
    )

}
