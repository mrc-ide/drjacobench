
<!-- README.md is generated from README.Rmd. Please edit that file -->

# drjacobench

Bench marking Drjacoby.

``` r

# Install and benchmark the first branch
remotes::install_github("mrc-ide/drjacoby@master", upgrade = "never")
Rcpp::sourceCpp(system.file("extdata", "rcpp_loglike_logprior.cpp", package = 'drjacobench', mustWork = TRUE))
branch1_benchmark <- drjacobench:::benchmark()
branch1_benchmark


#~#  Restart R #~# 


# Install and benchmark the second branch
remotes::install_github("mrc-ide/drjacoby@dj11", upgrade = "never")
cpp11::cpp_source(system.file("extdata", "cpp11_loglike_logprior.cpp", package = 'drjacobench', mustWork = TRUE))
branch2_benchmark <- drjacobench:::benchmark()
branch2_benchmark
```
