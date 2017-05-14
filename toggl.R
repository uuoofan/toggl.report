#' ---
#' title: "Toggl Report on `r Sys.Date()`"
#' authro: "Fan Wu"
#' output: md_document
#' ---


# install.packages("tm")
library(pdftools)
library(lubridate)
library(knitr)
# fname = "Toggl_projects_2017-05-09_to_2017-05-09"
# Just wanna make sure I can do this vvv :)
# tday = gsub("(\\S+)(\\d{4}\\-\\d{2}\\-\\d{2})", "\\2", fname)
toggl.report = function(fname){

  tday = as.Date(substr(fname, 30, 39))
  tmp = pdf_text(paste0(fname, ".pdf"))
  time.entry = unlist(strsplit(tmp[2], "\n"))
  time.entry = time.entry[-1]
  time.entry = time.entry[-length(time.entry)]
  # cat.entry = grep("^\\S", time.entry, value = TRUE)
  # cats = gsub("\\s+$", "", gsub("(.+)(\\d+:\\d+:\\d+)", "\\1", cat.entry))
  cats.csv = read.csv(paste0(fname, ".csv"), as.is = TRUE)
  cats = cats.csv$Project
  cat.id = grep("^\\S", time.entry)
  cat.no = c(diff(cat.id), length(time.entry) + 1 - tail(cat.id, 1))
  cats = rep(cats, cat.no)
  evt = gsub("^\\s|\\s+$", "", gsub("(.+)(\\d+:\\d+:\\d+)", "\\1", time.entry))
  dur = gsub("(.+)(\\d+:\\d+:\\d+)", "\\2", time.entry)

  dat = data.frame(Date = tday, Event = evt, Category = cats, Duration = hms(dur))
  dat = dat[-cat.id, ]
  rownames(dat) = NULL
  # print(kable(dat))
  dat
}

uniq.reports = unique(substr(grep("(\\S+)(\\d{4}\\-\\d{2}\\-\\d{2})", dir(), value = TRUE), 1, 39))
toggls = NULL
for(tr in uniq.reports){
  toggls = rbind(toggls, toggl.report(tr))
}
kable(toggls)

# "🍱"

