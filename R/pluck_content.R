pluck_content <- function(res) {
  res |>
    httr::content(type = "text") |>
    jsonlite::fromJSON()
}
