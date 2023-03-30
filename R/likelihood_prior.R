# Log-likelihood function
r_loglike <- function(params, data, misc) {

  # extract parameter values
  mu <- params["mu"]
  sigma <- params["sigma"]

  # calculate log-probability of data
  ret <- sum(stats::dnorm(data$x, mean = mu, sd = sigma, log = TRUE))

  # return
  return(ret)
}

# Log-prior function
r_logprior <- function(params, misc) {

  # extract parameter values
  mu <- params["mu"]
  sigma <- params["sigma"]

  # calculate log-prior
  ret <- stats::dunif(mu, min = -10, max = 10, log = TRUE) +
    stats::dlnorm(sigma, meanlog = 0, sdlog = 1.0, log = TRUE)

  # return
  return(ret)
}
