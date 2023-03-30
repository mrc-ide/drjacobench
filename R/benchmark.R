create_inputs <- function(mu_true = 3, sigma_true = 2){
  set.seed(1)
  # draw example data
  data_list <- list(x = rnorm(10, mean = mu_true, sd = sigma_true))
  df_params <- drjacoby::define_params(name = "mu", min = -10, max = 10,
                             name = "sigma", min = 0, max = Inf)

  return(
    list(
      data_list = data_list,
      df_params = df_params
    )
  )
}

benchmark<- function(rungs = 5L, chains = 5L, samples = 1000L, burnin = 5000L){
  input <- create_inputs()

  bm <- bench::mark(
    r_1chain_1rung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = r_loglike,
      logprior = r_logprior,
      chains = 1L,
      rungs = 1L,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    cpp_1chain_1rung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = "cpp_loglike",
      logprior = "cpp_logprior",
      chains = 1L,
      rungs = 1L,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    r_manychain_1rung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = r_loglike,
      logprior = r_logprior,
      chains = chains,
      rungs = 1L,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    cpp_manychain_1rung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = "cpp_loglike",
      logprior = "cpp_logprior",
      chains = chains,
      rungs = 1L,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    r_1chain_manyrung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = r_loglike,
      logprior = r_logprior,
      chains = 1L,
      rungs = rungs,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    cpp_1chain_manyrung = drjacoby::run_mcmc(
      data = input$data_list,
      df_params = input$df_params,
      loglike = "cpp_loglike",
      logprior = "cpp_logprior",
      chains = 1L,
      rungs = rungs,
      samples = samples,
      burnin = burnin,
      silent = TRUE
    ),
    check = FALSE,
    iterations = 5,
    time_unit = "ms"
  )
  return(bm)
}
