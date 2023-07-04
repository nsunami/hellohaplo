#' Download all ethics applications
#'
#' @param file output file
#' @param ethics_application_ref the ref for ethics application set by the "ETHICS_APPLICATIONS_REF" env var
#' @param sample_n the size of the sampled applications (optional)
#'
#' @return a tibble
#' @export
#'
#' @examples
#' tmp <- tempfile()
#' download_ethics_applications(tmp, sample_n = 10)
download_ethics_applications <- function(file,
    ethics_application_ref = Sys.getenv("ETHICS_APPLICATIONS_REF"),
    sample_n = NULL){
  
  # Get the linked objects
  all_ethics_refs <- get_linked_objects(ethics_application_ref)
  
  # Sample when parameter is specified - primarily for testing
  if(!is.null(sample_n)){
    all_ethics_refs <- all_ethics_refs |>
      sample(size = sample_n)
  }
  
  # Create a df for all applications
  ethics_applications <- dplyr::tibble(
    app_ref = all_ethics_refs
  )
  
  ## Query all applications ** Takes a long time!!! **
  cat("Downloading all applications...")
  start_time <- Sys.time()
  ethics_applications <- ethics_applications |>
    dplyr::mutate(res = purrr::map(
      app_ref,
      get_object_info
    ))
  end_time <- Sys.time()
  cat(end_time - start_time)
  
  # Return the tibble only with the ref and content
  output_df <- ethics_applications |>
    dplyr::transmute(app_ref,
                     content = purrr::map(
                       res,
                       get_content
                     ))
  
  # Write out the tibble 
  readr::write_rds(output_df, 
                   file)
  invisible(output_df)
}