% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_age.R
\name{check_age}
\alias{check_age}
\title{Check consistency between age and dates.}
\usage{
check_age(age, birth_date = NULL, onset_date = NULL)
}
\arguments{
\item{age}{Age.}

\item{birth_date}{Birth date of cancer case.}

\item{onset_date}{Incidence date of cancer.}
}
\value{
Class of 'check'.
}
\description{
Check consistency between age and dates.
}
\examples{
age <- c(58, 59, 60)
birth <- c("1960-08-24", "1956-09-24", "1971-06-30")
onset <- c("2024-09-10", "2024-08-10", "2023-09-11")
check_age(age, birth, onset)
}
