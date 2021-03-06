\name{NMFstd-class: Model class for standard NMF}
\Rdversion{1.1}
\docType{class}
\alias{NMFstd-class}
\alias{fitted,NMFstd-method}
\alias{basis,NMFstd-method}
\alias{basis<-,NMFstd,matrix-method}
\alias{coef,NMFstd-method}
\alias{coef<-,NMFstd,matrix-method}

\title{Implement of the standard NMF model}
\description{Class that implements the standard model of Nonnegative Matrix Factorisation.

It provides a general structure and generic functions to manage factorizations 
that follow NMF standard model.
}
 
\section{Slots}{
	 \describe{
    \item{\code{W}:}{A \code{"matrix"} that contains the \emph{first} matrix factor of the factorisation }
    \item{\code{H}:}{A \code{"matrix"} that contains the \emph{second} matrix factor of the factorisation }
  }
}

\details{
 Let \eqn{V} be a \eqn{n \times m} non-negative matrix and \eqn{r} a positive integer. 
 In its standard form (see references below), a NMF of \eqn{V} is commonly defined 
 as a pair of matrices \eqn{(W, H)} such that:
 
 \deqn{V \equiv W H,}
       
 where:
 \itemize{
 \item \eqn{W} and \eqn{H} are \eqn{n \times r} and \eqn{r \times m} 
 matrices respectively with non-negative entries;
 \item \eqn{\equiv} is to be understood with respect to some loss function. 
 Common choices of loss functions are based on Frobenius norm or 
 Kullback-Leibler divergence. 
}

 Integer \eqn{r} is called the \emph{factorization rank}.
 Depending on the context of application of NMF, the columns of \eqn{W} and \eqn{H} take different names:
 \describe{
 \item{columns of \eqn{W}}{basis vector, metagenes, factors, source, image basis}
 \item{columns of \eqn{H}}{mixture coefficients, metagenes expression profiles, weights}
 }
 
 NMF approach has been successfully applied to several fields. Package NMF was 
 implemented trying to use names as generic as possible for objects and methods. 
 The following terminology is used:
 \describe{
 \item{samples}{the columns of the target matrix \eqn{V}}
 \item{features}{the rows of the target matrix \eqn{V}}
 \item{basis matrix}{the first matrix factor \eqn{W}}
 \item{basis vectors}{the columns of first matrix factor \eqn{W}} 
 \item{mixture matrix}{the second matrix factor \eqn{H}}
 \item{mixtures coefficients}{the columns of second matrix factor \eqn{H}}
 }
 
 However, because package NMF was primilary implemented to work with gene expression 
 microarray data, it also provides a layer to easily and intuitively work 
 with objects from the Bioconductor base framework. 
 See \link{bioc-NMF} for more details.
 
 }
 
 \section{Validity checks}{ 
 
 The validity method for class \code{NMF} checks for compatibility of slots
 \code{W} and \code{H}, as those matrices must be compatible with respect to 
 the matrix product. It also checks the relevance of the factorisation, and 
 throws a warning when the factorisation rank is greater than the number of 
 columns in \code{H}.
 
 }
 
\section{Objects from the Class}{

\strong{Factory method}

The more convenient way of creating \code{NMF} objects is to use factory method 
\code{nmfModel}: 

\code{nmfModel(rank=0, target=0, model='NMFstd', ...)}

It provides a unique interface to create \code{NMF} objects that can follow 
different NMF models, and is designed to resolve potential inconsistencies 
in the matrices dimensions. See \code{\link{nmfModel}}.

For example, to build a 5-rank NMF model compatible to fit a given matrix \var{V}, 
one calls:

\code{nmfModel(5, V)}

If the factors \eqn{W} and \eqn{H} are already available, they can be used to initialise 
the model:

\code{nmfModel(5, V, W=w, H=h)}

\strong{Standard way}

Objects can still be created by calls of the usual form:

\code{new("NMF")} 

\code{new("NMF", W=w, H=h)} 
 
}

\section{Methods}{
  \describe{
%    \item{annotate}{\code{signature(x = "NMF", annotation = "character")}: ... }
    
    \item{distance}{\code{signature(target = "matrix", x = "NMF")}: return the 
    value of the loss function given a target matrix and a NMF fit. 
    %See function \code{\link{distance}} for more details.
    }

    \item{fitted}{\code{signature(object = "NMF")}: 
    compute the estimated target matrix according to the standard NMF model 
    \code{object}, i.e. as the matrix product of slots \code{W} and \code{H}.
    
    Note that this method is part of the minimum interface for NMF model, as 
    defined by class \code{\linkS4class{NMF}}.
    }

    \item{basis}{\code{signature(object = "NMF")}: Returns slot \code{W}, the 
    matrix of basis vectors in NMF model \code{object}. 
    
    Note that this method is part of the minimum interface for NMF models, as 
    defined by class \code{NMF}. See \code{\linkS4class{NMF}}.
    }

    \item{basis<-}{\code{signature(object = "NMF", value = "matrix")}: Sets the 
    value of slot \code{W}, the matrix of basis vectors in NMF model \code{object}.
    
    Note that this method is part of the minimum interface for NMF models, as 
    defined by class \code{NMF}. See \code{\linkS4class{NMF}}.
    }

    \item{coef}{\code{signature(object = "NMF")}: Returns slot \code{H}, 
    the matrix of mixture coefficients in the NMF model \code{object}.
    
    Note that this method is part of the minimum interface for NMF models, as 
    defined by class \code{NMF}. See \code{\linkS4class{NMF}}.
    }

    \item{coef<-}{\code{signature(object = "NMF", value = "matrix")}: Set the 
    value of slot \code{H}, the matrix of mixture coefficients in the NMF model 
    \code{object}. 
    
    Note that this method is part of the minimum interface for NMF models, as 
    defined by class \code{NMF}. See \code{\linkS4class{NMF}}.
    }

    \item{rnmf}{\code{signature(x = "NMF", target)}: seed NMF model \code{x} 
    with random values drawn from a random distribution. 
    If a target is specified as a \code{matrix}, then the values are drawn within 
    the interval \code{[0, max(target)]}. }    

    \item{show}{\code{signature(object = "NMF")}: standard generic \code{show} 
    method for objects of class \code{NMF}. }

    \item{summary}{\code{signature(x = "NMF")}: standard generic \code{summary} 
    method for objects of class \code{NMF}. }
	
	}
	
	Class \code{NMFstd} inherits from all the methods defined on class \code{NMF} 
	to manipulate and interpret NMF models. 
	Some useful are: \code{dim}, \code{nbasis}, \code{predict}, \code{sparseness}. 
	See \code{\linkS4class{NMF}} for more details.
	
}
\references{ 

	Definition of Nonnegative Matrix Factorization in its modern formulation:
	
	Lee D.D. and Seung H.S. (1999).
	Learning the parts of objects by non-negative matrix factorization. 
	\emph{Nature}, \bold{401}, 788--791.

	Historical first definition and algorithms: 
		
	Paatero, P., Tapper, U. (1994).
	Positive matrix factorization: A non-negative factor model with optimal utilization of error estimates of data values.
	\emph{Environmetrics}, \bold{2}, 111--126
	, doi:10.1002/env.3170050203.
	
	
	Reference for some utility functions:
	
	Kim, H. and Park, H. (2007).
	Sparse non-negative matrix factorizations via alternating non-negativity-constrained least squares for microarray data analysis.
	\emph{Bioinformatics}.
	
	Hoyer (2004).
	Non-negative matrix factorization with sparseness constraints.
	\emph{Journal of Machine Learning Research}, \bold{5}, 1457-1469.
	
	
}
\author{ Renaud Gaujoux  }

\seealso{
	Main interface to perform NMF in \code{\link{nmf-methods}}. 
	
	Method \code{\link{seed}} to set NMF objects with values suitable to start 
	algorithms with. 
}
\examples{

# create a completely empty NMF object (i.e. 0 features, 0 basis components, 0 samples)
new('NMFstd')

# create a NMF object based on one random matrix: the missing matrix is deduced
# Note this only works when using factory method NMF 
n <- 50; r <- 3; 
w <- rmatrix(n, r) 
nmfModel(W=w)

# create a NMF object based on random (compatible) matrices
p <- 20
h <- rmatrix(r, p)
nmfModel(W=w, H=h)

# create a NMF object based on incompatible matrices: generate an error
h <- rmatrix(r+1, p)
\dontrun{
new('NMFstd', W=w, H=h)
nmfModel(w, h)
}

# Giving target dimensions to the factory method allow for coping with dimension
# incompatibilty (a warning is thrown in such case) 
nmfModel(r, W=w, H=h)



}
\keyword{classes}
