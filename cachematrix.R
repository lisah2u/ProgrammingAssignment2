# Compute the inverse of a square matrix using the `solve`
# function in R. if `X` is a square invertible matrix, then
# `solve(X)` returns its inverse. 

# The purpose of makeCacheMatrix is to cache the value of the inverse 
# matrix so that when we need it again, it can be looked up in the cache 
# rather than recomputed

# `makeCacheMatrix`has functions which: 
#  set - sets the value of the matrix
#  get - returns the original matrix
#  setsolve - sets the inverse of the matrix
#  getsolve -  returns the inverse of the matrix

# http://adv-r.had.co.nz/Environments.html
# The deep assignment arrow, <<-, does not create a variable in the current 
# environment, but modifies an existing variable found in parent environments. 
# Closures and <<- make it possible to maintain state across function calls.

# Unit tests in cachematrix-test.R

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(s) m <<- s
  getsolve <- function() m
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}

# 'cacheSolve' computes the inverse of the matrix returned by `makeCacheMatrix` 
# above. If the inverse has already been calculated (and the matrix has not 
# changed), then`cacheSolve` retrieves the inverse from the cache and
# returns that.The matrix is expected to always be invertable.

cacheSolve <- function(x, ...) {
  m <- x$getsolve()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)  # when solve has only 1 matrix, it returns the inverse
  x$setsolve(m)
  m
}
