#' Find longest duplicate sequence
#' @description Finds the longest sequence of (offset) duplicate values
#' @param vec Numeric vector to test for (offset) duplicate values
#' @param min Minimum length sequence to search for. Recommend at least 4 to avoid false positives
#' @param max Maximum length sequence to search for. If missing, finds longest possible.
#' @param ... arguments to [sequence_thresh]
#' @details  Loops to find the longest possible sequence of (offset) duplicate values.
#' @examples
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4] + 2.03)
#' sequence_longest(vec = x)    
#' @export

sequence_longest <- function(vec, min = 4, max, ...){ 
  if(missing(max)){
    max <- length(vec) - 1
  }

  for(n in min:max){
    co <- sequence_cor(vec, n = n)
    th <- sequence_thresh(co, ...)
    if(!any(th, na.rm = TRUE)){
      n <- n - 1#last good 
      break
    }
  }

  if(n < min){
    n <- NA
  }
  n
} 
