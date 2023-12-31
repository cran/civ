% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/civ.R
\name{civ}
\alias{civ}
\title{Categorical Instrumental Variable Estimator.}
\usage{
civ(y, D, Z, X = NULL, K = 2)
}
\arguments{
\item{y}{The outcome variable, a numerical vector.}

\item{D}{A matrix of endogenous variables.}

\item{Z}{A matrix of instruments, where the first column corresponds to the
categorical instrument.}

\item{X}{An optional matrix of control variables.}

\item{K}{The number of support points of the estimated instrument
\eqn{\hat{m}_K}, an integer  greater than 2.}
}
\value{
\code{civ} returns an object of S3 class  \code{civ}. An object of
class \code{civ} is a list containing the following components:
\describe{
\item{\code{coef}}{A vector of second-stage coefficient estimates.}
\item{\code{iv_fit}}{Object of class \code{ivreg} from the IV
regression of \code{y} on \code{D} and \code{X} using the
the estimated \eqn{\hat{F}_K} as an instrument for \code{D}.
See also \code{\link[AER:ivreg]{AER::ivreg()}} for details.}
\item{\code{kcmeans_fit}}{Object of class \code{kcmeans} from the
K-Conditional-Means regression of \code{D} on \code{Z} and
\code{X}. See also \code{\link[kcmeans:kcmeans]{kcmeans::kcmeans()}} for details.}
\item{K}{Pass-through of selected user-provided arguments.
See above.}
}
}
\description{
Implementation of the categorical instrumental variable
estimator.
}
\examples{
# Simulate data from a simple IV model with 800 observations
nobs = 800 # sample size
Z <- sample(1:20, nobs, replace = TRUE) # observed instrument
Z0 <- Z \%\% 2 # underlying latent instrument
U_V <- matrix(rnorm(2 * nobs, 0, 1), nobs, 2) \%*\%
  chol(matrix(c(1, 0.6, 0.6, 1), 2, 2)) # first and second stage errors
D <- Z0 + U_V[, 2] # endogenous variable
y <- D + U_V[, 1] # outcome variable
# Estimate categorical instrument variable estimator with K = 2
civ_fit <- civ(y, D, Z, K = 3)
summary(civ_fit)
}
\references{
Fox J, Kleiber C, Zeileis A (2023). "ivreg: Instrumental-Variables Regression
by '2SLS', '2SM', or '2SMM', with Diagnostics". R package.

Wiemann T (2023). "Optimal Categorical Instruments."
}
