test_that("gh_api_status() works", {
  vcr::local_cassette("gh_api_status")
  status <- gh_api_status()
  expect_type(status, "character")
})
