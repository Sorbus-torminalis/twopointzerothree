#' Find longest duplicate sequence
#' @description Finds the longest sequence of (offset) duplicate values
#' @param vec Numeric vector to test for (offset) duplicate values
#' @param min Minimum length sequence to search for.
#' @param max Maximum length sequence to search for. If `NULL`, finds longest possible.
#' @param ... arguments to [sequence_thresh]
#' @details  Loops to find the longest possible sequence of (offset) duplicate values.
#' @examples
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4] + 2.03)
#' sequence_longest(vec = x)    
#' @export

sequence_longest <- function(vec, min = 3, max = NULL, ...){ 
  if(is.null(max)){
    max <- length(vec) - 1
  }
  th0 <- NA
  for(n in min:max){
    co <- sequence_cor(vec, n = n)
    th <- sequence_thresh(co, ...)
    if(any(th, na.rm = TRUE)){
      th0 <- th#grab last good
    } else {
      n <- n - 1#last good 
      break
    }
  }
  if(n < min){
    attr(th0, "longest") <- NA
    message("no duplicates length `min` found")
  } else{
    attr(th0, "longest") <- n
    message("longest duplicate length = ", n)
  }
  th0
} 
