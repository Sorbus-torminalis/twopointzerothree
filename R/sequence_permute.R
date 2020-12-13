#' Null expectation for apparent sequences
#' @description Vectors with low cardinality have a high risk of false positive duplicate sequences, especially for short sequences. sequence_permute permutes sequences and then tests for duplicates. 
#' 
#' @param vec vector with possible duplicates
#' @param min minimum length of sequence sought
#' @param max maximum length of sequence sought
#' @param nsamp number of replications
#' 
#' @examples 
#' #data from https://doi.org/10.5061/dryad.bd26mq0
#' TotalPrey <- c(4, 5, 4, 1, 3, 8, 2, 4, 7, 6, 1, 8, 3, 6, 2, 1, 3, 5, 2, 7, 
#' 1, 1, 3, 4, 4, 1, 3, 4, 3, 9, 2, 7, 6, 5, 3, 2, 4, 3, 4, 3, 2, 
#' 3, 4, 3, 3, 3, 2, 4, 4, 2, 2, 6, 4, 3, 5, 2, 4, 3, 5, 1, 3, 4, 
#' 4, 3, 1, 3, 2, 2, 3, 1, 4, 4, 3, 4, 3, 4, 3, 3, 7, 3, 4, 9, 2, 
#' 7, 3, 5, 2, 3, 6, 2, 4, 5, 2, 8, 5, 3, 4, 5, 6, 4, 3, 3, 4, 3, 
#' 2, 3, 2, 2, 2, 1, 1, 2, 1, 3, 4, 1, 2, 3, 3, 4, 1, 2, 3, 3, 2, 
#' 2, 3, 1, 5, 3, 4, 2, 2, 1, 1, 2, 1, 0, 1, 2) 
#'
#'suppressWarnings(
#'  res <- sequence_permute(TotalPrey, min = 5, max = 10, nsamp = 100)
#')# warnings when standard deviation = 0
#' res
#'library(ggplot2)
#'ggplot(res, aes(n, p)) + geom_col()
#' @importFrom dplyr ungroup mutate arrange group_by summarise %>%
#' @importFrom purrr set_names map_int
#' @importFrom tibble enframe
#' @importFrom rlang .data
#' @export

sequence_permute <- function(vec, min = 5, max = 10, nsamp = 100){
  min:max %>% 
    set_names() %>% 
    map_df(
      ~rerun(nsamp, sequence_find(vec = sample(vec), n = .x)) %>% 
        map_int(nrow) %>% 
        enframe(),
      .id = "n"
      ) %>% 
    group_by(.data$n) %>% 
    summarise(p = mean(.data$value > 0)) %>% 
    ungroup() %>% 
    mutate(n = as.integer(.data$n)) %>% 
    arrange(.data$n)
}