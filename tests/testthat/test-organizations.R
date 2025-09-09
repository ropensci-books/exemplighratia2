test_that("gh_organizations works", {
  vcr::local_cassette("gh_organizations")
  orgs <- gh_organizations()
  testthat::expect_type(orgs, "character")
})

test_that("gh_organizations errors when the API doesn't behave", {
  webmockr::enable()
  stub <- webmockr::stub_request(
    "get",
    "https://api.github.com/organizations?since=1"
  )
  webmockr::to_return(stub, status = 502)
  expect_snapshot(error = TRUE, gh_organizations())
  webmockr::disable()
})
