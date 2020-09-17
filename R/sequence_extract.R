#' extract duplicate sequences
#' @param th result of sequence_thresh
#' @param vec vector with possible duplicates
#' @importFrom plyr adply
#' @importFrom tibble tibble
#' @examples 
#' #' set.seed(42) 
#' x <- rnorm(10)
#' x <- c(x, x[1:4] + 2.03)
#' co <- sequence_cor(vec = x, n = 3) 
#' th <- sequence_thresh(co)
#' sequence_extract(th, vec = x)
#' @importFrom rlang .data
#' @export

sequence_extract <- function(th, vec){
  dups <- which(th, arr.ind = TRUE)
  dups <- dups[dups[, "row"] < dups[, "col"], , drop = FALSE]
  n <- attr(th, "len")
  plyr::adply(dups, 1, function(pos){
    tibble(pos1 = pos[1]:(pos[1] + n - 1),
           vec1 = vec[.data$pos1],
           pos2 = pos[2]:(pos[2] + n - 1),
           vec2 = vec[.data$pos2], 
           delta = .data$vec2 - .data$vec1)
  }, .id = "duplicate_no") 
}
