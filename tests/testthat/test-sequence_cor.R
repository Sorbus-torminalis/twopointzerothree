test_that("finds duplicates", {
  set.seed(42) 
  x <- rnorm(10)

  s1 <- sequence_cor(vec = x, n = 4) 
  
  #no duplicate
  expect_lt(max(s1, na.rm = TRUE), 1)
  
  #duplicate sequence
  x2 <- c(x, x[1:4] + 2.03)#with offset duplicate
  s2 <- segment_cor(vec = x2, n = 4) 
  expect_equal(max(s2, na.rm = TRUE), 1)
  
})
