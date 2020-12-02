test_that("rotation works", {
  x <- -9:9
  xrot <- rotate(x)
  expected <- c(1:5, -4:5, -4:-1)
  expect_equal(expected, xrot)
})


test_that("chi statistic works", {
  x <- c(35, 45, 55)
  a <- chisq.test(x)
  b<- chi(x)
  expect_equal(as.vector(a$statistic), b)
})
