# A helper function to get the matadata based on refs
add_metadata <- function(df) {
  df |>
    mutate(metadata = map(refs, function(ref) {
      get_object_metadata(ref)
    })) |>
    unnest(metadata)
}
