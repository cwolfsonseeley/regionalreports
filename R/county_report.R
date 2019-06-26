#' County Report
#'
#' This function creates a Regional Report for specified counties and outputs the report as an html file.
#' @param counties list of county codes from CDW
#' @param region_name name you'd like to give the regional area as it appears in the report
#' @param from start date in yyyymmdd format
#' @param to end date in yyyymmdd format
#' @param output file location and name for report
#' @export
#' @examples
#' # This would output the county report for Southern California from January 1, 2014 to June 30, 2018
#' county_report(counties = c("CA037", "CA059", "CA065", "CA071", "CA073", "CA083", "CA111"), region_name = "Southern California", from = 20140101, to = 20180630, output = "southern_ca_report")

county_report = function(counties, region_name, from, to, output) {
  wd = getwd()
  rmarkdown::render(
    "R:/Prospect Development/Prospect Analysis/regionalreports/R/county_analysis_template.Rmd", params = list(
      counties = counties,
      region_name = region_name,
      from = from,
      to = to
    ),
    output_file = normalizePath(paste0(wd,
                                       "\\",
                                       output, ".html"), mustWork = FALSE)  
  )
  region <- function(counties) {
    
    county_prospects <- discoveryengine::lives_in_county(counties) %>% display(household = TRUE) %>%
      write.csv(normalizePath(paste0(wd,
                                     "\\",
                                     output, ".csv"), mustWork = FALSE), row.names = FALSE)
    
    
  }
  

}



