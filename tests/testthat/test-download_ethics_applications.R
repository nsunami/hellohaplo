test_that("can download 10 sample ethics applications", {
  set.seed(8964)
  tmp <- tempfile()
  applications <- download_ethics_applications(tmp, 
                                               sample_n = 10)
  saved_file <- readr::read_rds(tmp)
  expect_equal(applications, saved_file)
})
