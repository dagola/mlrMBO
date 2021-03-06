% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MBOResult.R
\name{MBOSingleObjResult}
\alias{MBOSingleObjResult}
\title{Single-Objective result object.}
\description{
\itemize{
  \item{x [\code{list}]}{Named list of proposed optimal parameters.}
  \item{y [\code{numeric(1)}]}{Value of objective function at \code{x},
    either from evals during optimization or from requested final evaluations,
    if those were greater than 0.}
    \item{best.ind [\code{numeric(1)}]}{Index of \code{x} in the opt.path.}
  \item{opt.path [\code{\link[ParamHelpers]{OptPath}}]}{Optimization path.
    Includes all evaluated points and additional information as documented in \link{mbo_OptPath}.
    You can convert it via \code{as.data.frame}.}
  \item{resample.results [List of \code{\link[mlr]{ResampleResult}}]}{List of the desired \code{resample.results} if \code{resample.at} is set in \code{makeMBOControl}.}
  \item{final.state [\code{character}] The final termination state. Gives information why the optimization ended. Possible values are
     \describe{
       \item{term.iter}{Maximal number of iterations reached.}
       \item{term.time}{Maximal running time exceeded.}
       \item{term.exectime}{Maximal execution time of function evaluations reached.}
       \item{term.yval}{Target function value reached.}
       \item{term.fevals}{maximal number of function evaluations reached.}
       \item{term.custom}{Terminated due to custom, user-defined termination condition.}
    }
  }
  \item{models [List of \code{\link[mlr]{WrappedModel}}]}{List of saved regression models if \code{store.model.at} is set in \code{makeMBOControl}. The default is that it contains the model generated after the last iteration.}
  \item{control [\code{MBOControl}] Control object used in optimization}
}
}

