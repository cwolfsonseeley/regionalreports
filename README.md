
<!-- README.md is generated from README.Rmd. Please edit that file -->
regionalreports
===============

The regionalreports package comes out of a request for boilerplate reports based on prospects' geographic region, graduating school, or both. The functions take an MSA, a school (or both) plus start and end dates as arguments to output an html file that has summary level information, charts, and plots for prospects who are defined by those arguments.

The reports consider only graduates (both undergrad and grad) and parents of current students as prospects.

Installation
------------

You can install regionalreports from github with:

``` r
# install.packages("devtools")
devtools::install_github("cwolfsonseeley/regionalreports")
```

Example
-------

If you would like to run this report for all graduates of the College of Engineering and parents of current students at the College of Engineering who live in Boston, you would use the regional\_school\_report() function.

``` r
## first you'll need the codes for Boston and the College of Engineering
## there are various ways to find these, but perhaps the easiest is to use discoveryengine
discoveryengine::lives_in_msa(?boston)
#> Warning: package 'bindrcpp' was built under R version 3.4.4
#> Regular codes and synonyms:
#>                        synonym  code
#>  boston_cambridge_quincy_ma_nh 14460
discoveryengine::has_degree_from(?engineering)
#> Regular codes and synonyms:
#>                 synonym code
#>  college_of_engineering   EN
#>             engineering   EN
```

``` r
## now that you have those codes, use them as arguments in the function
## remember to put quotations around names of MSA and school
## remember dates go in yyyymmdd format
library(regionalreports)
regional_school_report(msa = 14460, msa_name = "Boston", school_code = "EN", school_name = "College of Engineering", from = 20140101, to = 20180630, output = "my_file/boston_engineering_report")
```
