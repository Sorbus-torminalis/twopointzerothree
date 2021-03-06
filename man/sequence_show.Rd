% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sequence_show.R
\name{sequence_show}
\alias{sequence_show}
\title{Show duplicate sequences in a datatable}
\usage{
sequence_show(data, meta_cols, test_cols, ...)
}
\arguments{
\item{data}{data.frame to with possible duplicates}

\item{meta_cols}{meta data to retain. Uses tidy-select}

\item{test_cols}{columns of data to test for duplicates. Uses tidy-select}

\item{...}{Arguments to sequence_extract_all}
}
\description{
Show duplicate sequences in a datatable
}
\details{
Highlights different sets of duplicates in a datatable. Adds extra columns before each tested column to show each duplicate set. Columns headers have the format number.number.number, where the first number refers to the number of the tested column, the second refers to the sequence length and the third is a unique identifier for each sequence length.
}
\examples{
data(kp2014)
sequence_show(kp2014, meta_cols = 1:3, test_cols = starts_with("Theridion"))
}
