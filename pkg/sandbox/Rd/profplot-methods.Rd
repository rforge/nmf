\name{Plotting Basis Profiles}
\docType{methods}
\alias{profplot}

\title{Plotting Basis Profiles}
\description{
The function \code{profplot} draw plots of the basis profiles, i.e. the rows of 
the mixture coefficient matrix of NMF models.
A given profile is composed of the contribution of the corresponding basis to 
each sample.

When using NMF for clustering in particular, one looks for strong associations 
between the basis and a priori known groups of samples.
Plotting the profiles may highlight such patterns.

The function can also be used to compare the profiles from two NMF models or
mixture coefficient matrices. In this case, it draws a scatter plot of 
the paired profiles.
 
}

\usage{

profplot(x, y, scale=FALSE, legend=TRUE, Colv, labels, annotation, ...)

}

\arguments{

	\item{x}{ a matrix or an NMF object from which is extracted the mixture 
	coefficient matrix. It is extracted from the best fit if \code{x} is the 
	results from multiple NMF runs.}
	
	\item{y}{ a matrix or an NMF object from which is extracted the mixture 
	coefficient matrix.It is extracted from the best fit if \code{y} is the 
	results from multiple NMF runs.}
	
	\item{scale}{ a logical that specifies whether the columns of the matrices 
	should be scaled into proportions (i.e. to sum up to one) before plotting.
	Default is \code{FALSE}.
	}
	
	\item{legend}{ a logical that specifies whether drawing the legend or not,
	or coordinates specifications passed to argument \code{x} of \code{\link{legend}}, 
	that specifies the position of the legend.}
	
	\item{Colv}{ specifies the way the columns of \code{x} are ordered before 
	plotting. It is used only when \code{y} is missing.
	It can be:
	\itemize{
	\item a single numeric value, specifying the index of a row of 
	\code{x}, that is used to order the columns by \code{x[, order(x[abs(Colv),])]}. 
	Decreasing order is specified with a negative index. 
	\item an integer vector directly specifying the order itself, in which case 
	the columns are ordered by \code{x[, Colv]}
	\item a factor used to order the columns by \code{x[, order(Colv)]} and as 
	argument \code{annotation} if this latter is missing or not \code{NA}.  
	\item any other object with a suitable \code{order} method. The columns are
	by \code{x[, order(Colv)]}
	}
	}
	
	\item{labels}{ a character vector containing labels for each sample (i.e. 
	each column	of \code{x}). These are used for labelling the x-axis.}
	
	\item{annotation}{ a factor annotating each sample (i.e. each column of 
	\code{x}). If not missing, a coloured raw is plotted under the x-axis and 
	annotates each sample accordingly. If argument \code{Colv} is a factor, 
	then it is used to annotate the plot, unless \code{annotation=NA}.}
	
	\item{...}{ graphical parameters passed to matplot.}

}

\seealso{ \code{\link{profcor}} }

\keyword{aplot}

\examples{

if( interactive() ){

# create a random target matrix
v <- rmatrix(50, 10)

# fit a single NMF model
res <- nmf(v, 3)
profplot(res)

# ordering according to first profile
profplot(res, Colv=1) # increasing
profplot(res, Colv=-1) # decreasing

# fit a multi-run NMF model
res2 <- nmf(v, 3, nrun=5)
profplot(res2)

# draw a profile correlation plot: this show how the basis components are 
# returned in an unpredictable order 
profplot(res, res2)

# looking at all the correlations allow to order the components in a "common" order
profcor(res, res2)

}

}


