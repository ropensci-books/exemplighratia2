with_mock_dir("gh_organizations", {
  test_that("gh_organizations works", {
    testthat::expect_type(gh_organizations(), "character")
  })
})

with_mock_dir("gh_organizations_error", {
  test_that("gh_organizations errors if the API doesn't behave", {
    testthat::expect_snapshot_error(gh_organizations())
  })
},
simplify = FALSE)
