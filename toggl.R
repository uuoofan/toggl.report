# install.packages("tm")
library(pdftools)
library(lubridate)
library(knitr)
tmp = pdf_text("./Toggl_projects_2017-05-07_to_2017-05-07.pdf")
time.entry = unlist(strsplit(tmp[2], "\n"))
time.entry = time.entry[-1]
time.entry = time.entry[-length(time.entry)]

# cat.entry = grep("^\\S", time.entry, value = TRUE)
# cats = gsub("\\s+$", "", gsub("(.+)(\\d+:\\d+:\\d+)", "\\1", cat.entry))
cats.csv = read.csv("./Toggl_projects_2017-05-07_to_2017-05-07.csv", as.is = TRUE)
cats = cats.csv$Project
cat.id = grep("^\\S", time.entry)
cat.no = c(diff(cat.id), length(time.entry) + 1 - tail(cat.id, 1))
cats = rep(cats, cat.no)
evt = gsub("^\\s|\\s+$", "", gsub("(.+)(\\d+:\\d+:\\d+)", "\\1", time.entry))
dur = gsub("(.+)(\\d+:\\d+:\\d+)", "\\2", time.entry)

dat = data.frame(Event = evt, Category = cats, Duration = hms(dur))
dat = dat[-cat.id, ]
rownames(dat) = NULL
kable(dat)

# "🍱"
