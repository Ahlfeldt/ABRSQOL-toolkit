# Whenever test data is changed these tests need updating! 
test_that("test data loaded and quality of live inversion successfull", {
  data(ABRSQOL_testdata)
  expect_equal(length(ABRSQOL_testdata), 10)
  expect_equal(length(ABRSQOL_testdata[[1]]), 141)
  qol <- ABRSQOL(df=ABRSQOL_testdata)
  expect_equal(length(qol), 141)
  expect_equal(round(sum(qol),2), round(128.3941,2))
})
