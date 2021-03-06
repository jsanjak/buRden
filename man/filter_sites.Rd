% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{filter_sites}
\alias{filter_sites}
\title{Apply frequency and LD filters to a genotype matrix}
\usage{
filter_sites(ccdata, ccstatus, minfreq, maxfreq, rsq_cutoff)
}
\arguments{
\item{ccdata}{A matrix of markers (columns) and individuals (rows).  Data are coded as the number of copies of the minor allele.}

\item{ccstatus}{A vector of binary phenotype labels.  0 = control, 1 = case.}

\item{minfreq}{A site with minor allele frequency < minfreq will not be kept.}

\item{maxfreq}{A site with minor allele frequency >= maxfreq will not be kept.}

\item{rsq_cutoff}{When comparing two sites, if the genotype correlation coefficient r^2 is >= rsq_cutoff, only the first site will be kept.}
}
\value{
A vector of integers containing the values 0 (not kept) and 1 (kept).  The length of the vector is equal to the number of columns in ccdata.
}
\description{
Apply frequency and LD filters to a genotype matrix
}
\details{
Regarding rsq_cutoff, when sites i and j are compared (j > i), site i will be kept and site j will not be kept.
}
\examples{
data(rec.ccdata)
status=c(rep(0,rec.ccdata$ncontrols),rep(1,rec.ccdata$ncases))
keep=filter_sites(rec.ccdata$genos,status,0,0.05,0.8)
}

