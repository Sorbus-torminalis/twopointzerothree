#' Find and extract duplicate sequences
#' @param vec vector with possible duplicates
#' @param max longest sequence sought
#' @examples 
#' #' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4] + 2.03)
#' sequence_find(vec = x, max = 5)
#' @export
sequence_find <- function(vec, max){
  s_long <- sequence_longest(vec, max = max)
  sequence_extract(s_long, vec)
}