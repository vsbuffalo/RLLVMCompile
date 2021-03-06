# subset.R - test subset functions

## Note the return type is a DoubleType, so createCast dereferences
## the DoublePtrType - this is unsafe. More elaborate pre-compiling
## checking will handle this.
t1 <- function(x, i) {
  a <- x[i]
  return(a)
}

t1.c <- compileFunction(t1, DoubleType, list(x=DoublePtrType, i=Int32Type), asList=TRUE, optimize=TRUE)
stopifnot(verifyModule(t1.c$mod))
stopifnot(run(t1.c$fun, c(1, 2, 3), 1L) == 2)


t2 <- function(x, i) {  
  b <- x[i] + 2.1
  return(b)
}

t2.c <- compileFunction(t2, DoubleType, list(x=DoublePtrType, i=Int32Type), asList=TRUE, optimize=FALSE)
stopifnot(verifyModule(t2.c$mod))
stopifnot(run(t2.c$fun, c(1, 2, 3), 1L) == 2)



t3 <- function(x, i) {
  a <- 20
  b <- x[i] + a
  return(b)
}


t3.c <- compileFunction(t3, DoubleType, list(x=DoublePtrType, i=Int32Type), asList=TRUE, optimize=FALSE)
stopifnot(verifyModule(t3.c$mod))
stopifnot(run(t3.c$fun, c(1, 2, 3), 1L) == 2)
