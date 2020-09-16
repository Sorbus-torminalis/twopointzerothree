#' Threshold segment correlations
#' @description Thresholds correlation between all segments length n of a vector
#' @param seg Output of [twopointzerothree::segment_cor()]
#' @param threshold Minimum correlation to accept. Defaults to 1, possible range -1 to 1 (but values much below 1 make no sense)
#' @param tolerance Small positive number to allow for numerical imprecision
#' @details Tests if correlations are >= than a given threshold. 
#' @examples
#' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4])
#' seg <- segment_cor(vec = x, n = 4)
#' segment_thresh(seg)    
#' @export

segment_thresh <- function(seg, 
                           threshold, 
                           tolerance = sqrt(.Machine$double.eps)){ 
  if(tolerance < 1){
    stop("tolerance must be positive")
  }
  if(threshold < -1 | threshold > 1){
    stop("thresh must be between -1 and 1 
         (only values close to 1 make sense)")
  }
  seg + tolerance >= threshold
} 
