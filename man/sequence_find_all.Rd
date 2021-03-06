% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sequence_find_all.R
\name{sequence_find_all}
\alias{sequence_find_all}
\title{Find and extract all duplicate sequences}
\usage{
sequence_find_all(vec, min = 4, max)
}
\arguments{
\item{vec}{vector with possible duplicates}

\item{min}{length of the shortest sequence of interest (high risk of false positives if this is short)}

\item{max}{length of longest sequence sought. If missing will find the length of the longest duplicate}
}
\description{
Find and extract all duplicate sequences
}
\examples{
data(kp2014)
sequence_find_all(
 vec = c(kp2014$`Theridion murarium Aggressiveness...4`,
        kp2014$`Theridion murarium Aggressiveness...5`,
        kp2014$`Theridion murarium Aggressiveness...6`), 
 max = 9)
}
