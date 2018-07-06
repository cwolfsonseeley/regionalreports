#' Regional School Report
#'
#' This function creates a Regional School Report for specified MSA and graduating school and outputs the report as an html file.
#' @param msa MSA code from CDW
#' @param msa_name name you'd like to give MSA as it appears in the report
#' @param school_code school code from CDW
#' @param school_name school name as you'd like it to appear in the report
#' @param from start date in yyyymmdd format
#' @param to end date in yyyymmdd format
#' @param output file location and name for report
#' @export
#' @examples
#' # This would output the report for Boston and the College of Engineering from January 1, 2014 to June 30, 2018
#' school_report(msa = 14460, msa_name = "Boston", school = EN, school_name = "College of Engineering", from = 20140101, to = 20180630, output = "my_file/boston_engineering_report")

regional_school_report = function(msa, msa_name, school, school_name, from, to, output) {
  rmarkdown::render(
    "R:/Prospect Development/Prospect Analysis/regionalreports/R/region_and_school_analysis_template.Rmd", params = list(
      msa = msa,
      msa_name = msa_name, 
      school = school,
      school_name = school_name,
      from = from,
      to = to
    ),
    output_file = paste0(output, ".html")
  )
}
