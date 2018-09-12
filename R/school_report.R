#' School Report
#'
#' This function creates a School Report for a specified graduating school and outputs the report as an html file.
#' @param school_code school code from CDW
#' @param school_name school name as you'd like it to appear in the report
#' @param from start date in yyyymmdd format
#' @param to end date in yyyymmdd format
#' @param output file location and name for report
#' @export
#' @examples
#' # This would output the school report for the College of Engineering from January 1, 2014 to June 30, 2018
#' school_report(school_code = "EN", school_name = "College of Engineering", from = 20140101, to = 20180630, output = "my_file/engineering_report")

school_report = function(school_code, school_name, from, to, output) {
  rmarkdown::render(
    "R:/Prospect Development/Prospect Analysis/regionalreports/R/school_analysis_template.Rmd", params = list(
      school_code = school_code,
      school_name = school_name,
      from = from,
      to = to
    ),
    output_file = normalizePath(paste0(output, ".html"), mustWork = FALSE) 
  )
}
