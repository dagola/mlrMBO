# Infill criteria.
# Used to select update/infill points to increase (global) model accuracy.
# CONVENTION: INFILL CRITERIA ARE ALWAYS MINIMIZED. SO A FEW BELOW ARE NEGATED VERSIONS!

#FIXME think about which criterias are for determinitic, which are for noisy case
# below is just guessed this...

# Please stick to the following general interface. 
#
# @param points [\code{data.frame}]\cr
#   Points where to evaluate.
# @param model [\code{\link{WrappedModel}}]\cr
#   Model fitted on design.
# @param control [\code{\link{MBOControl}}]\cr
#   Control object.
# @param par.set [\code{\link[ParamHelpers]{ParamSet}}]\cr
#   Parameter set.
# @param design [\code{data.frame}]\cr
#   Design of already visited points.
# @return [\code{numeric}]. Criterion values at \code{points}.

# MEAN RESPONSE OF MODEL
# (useful for deterministic and noisy)
infillCritMeanResponse = function(points, model, control, par.set, design) {
  ifelse(control$minimize, 1, -1) * predict(model, newdata = points)$data$response
}

# MODEL UNCERTAINTY
# (on its own not really useful for anything I suppose ...)
infillCritStandardError = function(points, model, control, par.set, design) {
  -predict(model, newdata = points)$data$se
}

# EXPECTED IMPROVEMENT
# (useful for deterministic)
infillCritEI = function(points, model, control, par.set, design) {
  maximize.mult = ifelse(control$minimize, 1, -1)
  y = maximize.mult * design[, control$y.name]
  p = predict(model, newdata = points)$data
  p.mu = maximize.mult * p$response
  p.se = p$se
  y.min = min(y)
  d = y.min - p.mu
  xcr = d / p.se
  #FIXME: what is done in DiceOption::EI here for numerical reasons?
  #if (kriging.sd/sqrt(model@covariance@sd2) < 1e-06) {
  #  res = 0
  #  xcr = xcr.prob = xcr.dens = NULL
  #
  xcr.prob = pnorm(xcr)
  xcr.dens = dnorm(xcr)
  ei = d * xcr.prob + p.se * xcr.dens
  # FIXME magic number
  # if se too low set 0 (numerical problems), negate due to minimization
  ifelse(p.se < 1e-6, 0, -ei)
}

# LOWER CONFIDENCE BOUND
# (useful for deterministic)
infillCritLCB = function(points, model, control, par.set, design) {
  maximize.mult = ifelse(control$minimize, 1, -1)
  p = predict(model, newdata = points)$data
  lcb = maximize.mult * (p$response - control$infill.crit.lcb.lambda * p$se)
  return(lcb)
}