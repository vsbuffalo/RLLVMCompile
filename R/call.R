callHandler =
  #
  # This handles calls to other functions.
  #
function(call, env, ir, ..., fun = env$.fun, name = getName(fun))
{
   ofun = findFun(as.character(call[[1]]), env)
     #??? Need to get the types of parameters and coerce them to these types.
     # Can we pass this to compile and have that do the coercion as necessary
   args = lapply(as.list(call[-1]), compile, env, ir, ...)  # ... and fun, name,
   ir$createCall(ofun, .args = args)
}

findFun =
function(id, env)
{
  funcs = getModuleFunctions(env$.module)
  if(id %in% names(funcs))
     funcs[[id]]
  else
    stop("Can't reference function ", id, " in module ") #, getName(env$.module))
}
