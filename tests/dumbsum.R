library(compiler)


dumbSum <- function(x, l) {
  sum <- 0
  for (i in 1:l) {
    sum <- x[i] + sum
  }
  return(sum)
}

l <- 1e7L
x <- rnorm(l)

dumbSum.rllvm <- compileFunction(dumbSum, DoubleType, list(x=DoublePtrType, l=Int32Type), asList=TRUE, optimize=TRUE, .insertReturn=FALSE)

dumbSum.compiler <- cmpfun(dumbSum)

times.rllvm <- replicate(20, system.time(run(dumbSum.rllvm$fun, x, l)))
times.compiler <- replicate(20, system.time(dumbSum.compiler(x, l)))
times.R <- replicate(20, system.time(dumbSum(x, l)))
times.sum <- replicate(20, system.time(sum(x)))


