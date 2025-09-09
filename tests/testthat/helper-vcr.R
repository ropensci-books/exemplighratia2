vcr_dir <- vcr::vcr_test_path("_vcr")
if (!gh::gh_token_exists()) {
  if (dir.exists(vcr_dir)) {
    # Fake API token to fool our package
    Sys.setenv("GITHUB_PAT" = "foobar")
  } else {
    # If there's no mock files nor API token, impossible to run tests
    stop("No API key nor cassettes, tests cannot be run.", call. = FALSE)
  }
}
