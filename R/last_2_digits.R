#' last two digits
#' @description Tests if the distribution of difference between the last two digits of a vector of numbers departs from the expected distribution
#' @param x Vector of integer values (either integer or numeric class)
#' @param n Number of replications required
#'
#' @examples
#' last2_diff_test(sample(10:99, size = 1000, replace = TRUE), 100)
#' last2_diff_test(c(10:99, 1 + rep(c(11 * (1:8)), 2)), 100)
#'
#' @importFrom dplyr near 
#' @importFrom purrr rerun map_dbl %>%
#' @importFrom tibble lst
#' @importFrom stats chisq.test
#' @export

last2_diff_test <- function(x, n = 100){
  
  #check (near) integer
  if(!all(near(x, round(x)))){
    stop("x must be a vector of integer values (not necessarily integer class)")
  }
  #round any remaining decimals
  x <- round(x)
  
  #last digit
  last1 <- x %% 10
  #penultimate digit
  last2 <- ((x %% 100) - last1)/10
  
  #find difference
  delta0 <- last1 - last2
  #rotate to -4:5 scale
  delta0 <- rotate(delta0)
  
  #count number of each digit - factor forces zero counts when needed
  delta0_count <- table(factor(delta0, levels = -4:5))
  #chi squared test - interested mainly in statistic (could speed up by calculating directly)
  delta0_chi <- chisq.test(delta0_count)

  #sample last n times and recount  
  delta1_counts <- purrr::rerun(n, {
    delta1 <- last2 - sample(last1)
    delta1 <- rotate(delta1)
    delta1_count <- table(factor(delta1, levels = -4:5))
    delta1_count
  })
  delta1_chi <- delta1_counts %>% map_dbl(chi)
  
  result <- lst(
    delta0_count = delta0_count, 
    delta1_counts = delta1_counts, 
    delta0_naive = delta0_chi$p.value,
    delta0_chi = delta0_chi$statistic,
    delta1_chi = delta1_chi,
    p = mean(c(delta0_chi, delta1_chi) >= delta0_chi)
  )
  
  return(structure(result, class = "last2"))
}

#' autoplot last2
#' @description autoplot function for result of last2_diff_test
#' @param x last2 object
#' @param ci quantile of null distribution to plot.
#' @importFrom ggplot2 ggplot aes geom_col scale_x_continuous geom_ribbon labs
#' @importFrom dplyr mutate group_by summarise
#' @importFrom tibble enframe
#' @importFrom rlang .data
#' @importFrom purrr map_df
#' @importFrom stats quantile

autoplot.last2 <- function(x, ci = 0.95){
  #ribbon showing null distribution
  #cols showing observed
  bars <- x$delta0_count %>% 
    enframe() %>% 
    mutate(name = as.numeric(.data$name), value = as.vector(.data$value))
  
  ribbon <- x$delta1_counts %>% 
    map_df(enframe) %>% 
    mutate(name = as.numeric(.data$name), value = as.vector(.data$value)) %>% 
    group_by(.data$name) %>% 
    summarise(lower = quantile(.data$value, probs = (1 - ci)/2), 
              upper = quantile(.data$value, probs = 1 - (1 - ci)/2))
  
  ggplot() +
    geom_col(data = bars, mapping = aes(x = .data$name, y = .data$value), orientation = "x") +
    geom_ribbon(data = ribbon, mapping = aes(x = .data$name, ymin = .data$lower, ymax = .data$upper), fill = "red", alpha = 0.3) +
    scale_x_continuous(breaks = -4:5) +
    labs(x = "Difference between last two digits", y = "Count")
  
}


#' Rotate
#' @description Rotates digits so they are arranged on -4:5 scale (ie +6 -> -4) 
#' @param x vector of integers
#' @importFrom dplyr case_when
rotate <- function(x){
  case_when(
    x > 5 ~ -10L + x,
    x < -4 ~ 10L + x, 
    TRUE ~ x)
}




#' Chi statistic
#' @description chisq.test stripped for speed
#' @param x vector to test

chi <- function (x) 
{
  if (any(x < 0) || anyNA(x)) 
    stop("all entries of 'x' must be nonnegative and finite")
  if ((n <- sum(x)) == 0) 
    stop("at least one entry of 'x' must be positive")
  if (length(x) == 1L) 
    stop("'x' must at least have 2 elements")
  
  p <- rep(1/length(x), length(x))
  E <- n * p
  V <- n * p * (1 - p)
  STATISTIC <- sum((x - E)^2/E)
  
  if (any(E < 5)) 
    warning("Chi-squared approximation may be incorrect")
  
  STATISTIC
}



