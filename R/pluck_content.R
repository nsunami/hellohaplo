pluck_content <- function(res) {
  res |>
    content(type = "text") |>
    fromJSON()
}
