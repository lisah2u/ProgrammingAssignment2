# Unit tests for cachematrix.R
# Useful discussion here:
# https://class.coursera.org/rprog-004/forum/thread?thread_id=153

# Source cachematrix.R before running.

# Create a square matrix and compute the inverse normally using
# solve(A).  Inverse of A where A is a square matrix.
A <- matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), nrow=3, ncol=3)
b <- 3
B <- diag(10,b,b)
C <- matrix(rnorm(1000000), 1000, 1000)
# system.time(solve(C))
# user  system elapsed 
# 1.033   0.002   1.034 
# Compare with system time at bottom of script

# Make cache matrix
s <- makeCacheMatrix()

# Set A
s$set(A)

# Get and print my matrix
s$get()

# Should return
#      [,1] [,2] [,3]
# [1,]    1    0    0
# [2,]    0    1    0
# [3,]    0    0    1

# returns NULL the first time since not chached
s$getsolve()

# cache it
cacheSolve(s)

# print the cached matrix
s$getsolve()

# Some timing information
s$set(C)
cacheSolve(s)
system.time(s$getsolve())   # compare with time above... nicely cached!
# user  system elapsed 
# 0       0       0 