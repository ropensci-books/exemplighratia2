gh_v3_url <- function() {
  "https://api.github.com/"
}

#' GitHub organizations
#'
#' @description Get logins of GitHub organizations.
#'
#' @param since The integer ID of the last organization that you've seen.
#'
#' @return A character vector of at most 30 elements.
#' @export
#'
#' @details Refer to https://developer.github.com/v3/orgs/#list-organizations
#'
#' @examples
#' \dontrun{
#' gh_organizations(since = 42)
#' }
gh_organizations <- function(since = 1) {

  token <- Sys.getenv("GITHUB_PAT")

  if (!nchar(token)) {
    stop("No token provided! Set up the GITHUB_PAT environment variable please.")
  }

  response <- httr2::request(gh_v3_url()) %>%
    httr2::req_url_path_append("organizations") %>%
    httr2::req_url_query(since = since) %>%
    httr2::req_headers("Authorization" = paste("token", token)) %>%
    httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
    httr2::req_perform()

  httr2::resp_check_status(response)

  content <- httr2::resp_body_json(response)

  purrr::map_chr(content, "login")

}
