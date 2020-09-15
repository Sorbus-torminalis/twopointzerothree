#' segment_cor
#' @param vec numeric vector to test for possible offset duplicate sequences
#' @param n length of duplicate sequence to search for
#' @details Embeds the vector into low-dimensional Euclidean space and then finds correlation between all columns. Pairs of columns with a correlation of 1 are either duplicates or have an offset. 
#' @examples
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4])
#' segment_cor(vec = x, n = 4)
#' @importFrom stats cor embed
#'    
#' @export

segment_cor <- function(vec, n){ 
  em <- embed(vec, length(vec) - n + 1) 
  co <- cor(em)
  diag(co) <- NA
  co
} 
