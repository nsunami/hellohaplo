#' Get people associated with a faculty 
#'
#' @param faculty_ref A ref for a faculty object
#' @param sources Sources as per API
#' @param key Haplo API Key
#'
#' @return A character vector of refs
#' @export
#'
#' @examples
#' get_people_by_faculty("801yv")
get_people_by_faculty <- function(faculty_ref, sources = "NONE",
                                  key = Sys.getenv("HAPLO_API_KEY")) {
  query_api <- function(facutly_ref, start = 0, key) {
    httr::GET(paste0("https://ethicsmonitor.eur.nl/api/v0-object/linked/", faculty_ref),
      httr::authenticate("haplo", key),
      query = list(
        sources = sources,
        start = start
      )
    ) |>
      httr::content("text") |>
      jsonlite::fromJSON()
  }

  res <- query_api(faculty_ref, key = key)
  # Prepare an initial vector
  refs <- as.vector(res$refs)
  while (res$results$more) {
    res <- query_api(faculty_ref, start = res$results$end, key = key)
    refs <- refs |>
      append(res$refs)
    print(res$results$end)
  }
  refs
}
