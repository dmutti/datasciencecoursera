## Matrix inversion is usually a costly computation and their may
## be some benefit to caching the inverse of a matrix rather than
## compute it repeatedly

## Functions makeCacheMatrix and cacheSolve work in pair to cache
## the inverse of a matrix

## example
## x <- makeCacheMatrix(matrix(1:4,2,2))
## cacheSolve(x)

## makeCacheMatrix
## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    if (!is.matrix(x) && is.na(x)) {
        stop("NA not supported")
    } else if (nrow(x) != ncol(x)) {
        stop("only square matrices accepted")
    }

    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setsolve <- function(solve) m <<- solve
    getsolve <- function() m
    list(set = set, get = get,
         setsolve = setsolve,
         getsolve = getsolve)
}


## cacheSolve
## This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix above. If the inverse has already been calculated (and
## the matrix has not changed), then the cacheSolve should retrieve the
## inverse from the cache.
## ***This implementation assumes that the matrix supplied is always invertible.***
cacheSolve <- function(x, ...) {
    if (is.na(x)) {
        stop("NA not supported")
    }
    m <- x$getsolve()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setsolve(m)
    m
}
