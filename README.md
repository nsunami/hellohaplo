
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hellohaplo

<!-- badges: start -->
<!-- badges: end -->

The goal of hellohaplo is to communicate with the [Haplo’s REST
API](https://docs.haplo.org/rest-api) from R.

## Installation

You can install the development version of hellohaplo from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nsunami/hellohaplo")
```

## Usage

First, set the following environment variables:

- `HAPLO_API_KEY` to your API Key.
- `HAPLO_BASE_URL` to the hostname of the Haplo app (e.g., for EUR, it’s
  <https://ethicsmonitor.eur.nl/>)

``` r
library(hellohaplo)
# Sys.setenv("HAPLO_API_KEY" = "YOUR_API_KEY_HERE")
# Sys.setenv("HAPLO_BASE_URL" = "https://ethicsmonitor.eur.nl/")
```

You can also use .Renviron to set your environment variable.

Then, you can get information about your Haplo object, using the ref of
a named object.

``` r
res_84190 <- get_object_info("84190")
res_84190
#> Response [https://ethicsmonitor.eur.nl/api/v0-object/ref/84190?sources=ALL]
#>   Date: 2023-04-01 15:21
#>   Status: 200
#>   Content-Type: application/json; charset=utf-8
#>   Size: 1.49 kB
```

Use `get_content` to get an R object of the response.

``` r
content_84190 <- get_content(res_84190)
#> No encoding supplied: defaulting to UTF-8.
content_84190$object$title
#> [1] "Nami Sunami"
```

For an ethics application object, you can also use `get_object_info()`
to get the info. Then, you can use `pluck_applicant()` to get the list
of pplicants.

``` r
# Ethics application 842q0
application_842q0 <- get_object_info("842q0")
content_842q0 <- application_842q0 |>
  get_content()
#> No encoding supplied: defaulting to UTF-8.
# Get the applicants associated with the application
content_842q0 |> 
  pluck_applicant()
#> [1] "84190"
```

## Caveat

Please note the funcions in this package are tested on the EUR’s
instance and object model, and thus they may not work on the object
model for non-EUR instance.

## Licensing

All non-code materials are licensed under CC BY 4.0. All codes are under
MIT license.
