get_people_by_faculty <- function(faculty_ref, sources = "NONE", query = NULL, key) {
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
