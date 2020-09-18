#' Find and extract duplicate sequences
#' @param vec vector with possible duplicates
#' @param n length of sequence sought
#' @examples 
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4] + 2.03)
#' sequence_find(vec = x, n = 5)
#' @export
sequence_find <- function(vec, n){
  co <- sequence_cor(vec = vec, n = n)
  th <- sequence_thresh(co)
  sequence_extract(th, vec)
}