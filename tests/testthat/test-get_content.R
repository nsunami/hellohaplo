test_that("resulting object is a list", {
  res <- httr::GET("https://httpbin.org/get")
  plucked <- get_content(res)
  
  expect_type(plucked, "list")
})
