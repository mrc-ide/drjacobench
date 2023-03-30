#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
SEXP cpp_loglike(Rcpp::NumericVector params, Rcpp::List data, Rcpp::List misc) {

  // extract parameters
  double mu = params["mu"];
  double sigma = params["sigma"];

  // unpack data
  std::vector<double> x = Rcpp::as< std::vector<double> >(data["x"]);

  // sum log-likelihood over all data
  double ret = 0.0;
  for (unsigned int i = 0; i < x.size(); ++i) {
    ret += R::dnorm(x[i], mu, sigma, true);
  }

  // return as SEXP
  return Rcpp::wrap(ret);
}

// [[Rcpp::export]]
SEXP cpp_logprior(Rcpp::NumericVector params, Rcpp::List misc) {

  // extract parameters
  double sigma = params["sigma"];

  // calculate cpp_logprior
  double ret = -log(20.0) + R::dlnorm(sigma, 0.0, 1.0, true);

  // return as SEXP
  return Rcpp::wrap(ret);
}

// [[Rcpp::export]]
SEXP create_xptr(std::string function_name) {
  typedef SEXP (*funcPtr_likelihood)(Rcpp::NumericVector params, Rcpp::List data, Rcpp::List misc);
  typedef SEXP (*funcPtr_prior)(Rcpp::NumericVector params, Rcpp::List misc);

  if (function_name == "cpp_loglike"){
    return(Rcpp::XPtr<funcPtr_likelihood>(new funcPtr_likelihood(&cpp_loglike)));
  }
  if (function_name == "cpp_logprior"){
    return(Rcpp::XPtr<funcPtr_prior>(new funcPtr_prior(&cpp_logprior)));
  }

  stop("cpp function %i not found", function_name);
}
