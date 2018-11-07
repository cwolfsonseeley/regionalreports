#' Regional Report
#'
#' This function creates a Regional Report for a specified MSA and outputs the report as an html file.
#' @param msa MSA code from CDW
#' @param msa_name name you'd like to give MSA as it appears in the report
#' @param from start date in yyyymmdd format
#' @param to end date in yyyymmdd format
#' @param output file location and name for report
#' @export
#' @examples
#' # This would output the regional report for Boston from January 1, 2014 to June 30, 2018
#' regional_report(msa = 14460, msa_name = "Boston", from = 20140101, to = 20180630, output = "my_file/boston_report")

regional_report = function(msa, msa_name, from, to, output) {
  wd = getwd()
  rmarkdown::render(
    "R:/Prospect Development/Prospect Analysis/regionalreports/R/regional_analysis_template.Rmd", params = list(
      msa = msa,
      msa_name = msa_name,
      from = from,
      to = to
    ),
    output_file = normalizePath(paste0(wd,
                                       "\\",
                                       output, ".html"), mustWork = FALSE)  
  )
  region <- function(msa) {
    
    regional_query <- getcdw::parameterize_template("R:/Prospect Development/Prospect Analysis/regionalreports/sql/region/region.sql")
    getcdw::get_cdw(regional_query(msa = msa))
  }
  
  region_prospects <- region(msa = msa) %>%
    select(entity_id, hh_id) %>% 
    distinct %>%
    write.csv(normalizePath(paste0(wd,
                                   "\\",
                                   output, ".csv"), mustWork = FALSE), row.names = FALSE)
  
}



