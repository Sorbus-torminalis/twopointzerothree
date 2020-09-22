#' Find and extract all duplicate sequences
#' @param vec vector with possible duplicates
#' @param max length of longest sequence sought. If missing will find the length of the longest duplicate
#' @param min length of the shortest sequence of interest (high risk of false positives if this is short)
#' @examples 
#' data(kp2014)
#' sequence_find_all(
#'  vec = c(kp2014$`Theridion murarium Aggressiveness...4`,
#'         kp2014$`Theridion murarium Aggressiveness...5`,
#'         kp2014$`Theridion murarium Aggressiveness...6`), 
#'  max = 9)
#' @importFrom dplyr anti_join bind_rows
#' @export
sequence_find_all <- function(vec, min = 4, max){
  if(missing(max)){
    max <- sequence_longest(vec = vec, min = min, max = max)
  }
  if(is.na(max)){#no dups found
    max <- min
  }
  results <- list()
  for(n in max:min){
    results[[max - n + 1]] <- sequence_find(vec = vec, n = n)
  }
  results2 <- list()
  results2[[1]] <- results[[1]]
  if(length(results) > 1){
    for(i in 2:length(results)){
      results2[[i]] <- anti_join(results[[i]], results[[i - 1]],
                                 by = c("pos1", "pos2"))
    }
  }
  bind_rows(results2)
  
}