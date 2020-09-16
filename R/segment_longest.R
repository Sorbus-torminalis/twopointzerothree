#' Find longest duplicate sequence
#' @description Finds the longest sequence of (offset) duplicate values
#' @param vec Numeric vector to test for (offset) duplicate values
#' @param min Minimum length sequence to search for.
#' @param max Maximum length sequence to search for. If `NULL`, finds longest possible.
#' @param ... arguments to [segment_thresh]
#' @details  Loops to find the longest possible sequence of (offset) duplicate values.
#' @examples
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4])
#' segment_longest(vec = x)    
#' @export

segment_longest <- function(vec, min = 3, max = NULL, ...){ 
  if(is.null(max)){
    max <- length(vec) - 1
  }
  th <- list()
  for(n in min:max){
    co <- segment_cor(vec, n = n)
    th[[n]] <- segment_thresh(co, ...)
    if(!any(th[[n]], na.rm = TRUE)){
      break
    }
  }
  th
} 
