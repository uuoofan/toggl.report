    # install.packages("tm")
    # .libPaths("/Library/Frameworks/R.framework/Versions/3.3/Resources/library")
    library(pdftools)
    library(lubridate)

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

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

<table>
<thead>
<tr class="header">
<th align="left">Date</th>
<th align="left">Event</th>
<th align="left">Category</th>
<th align="right">Duration</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">吃三明治</td>
<td align="left">外食🍱</td>
<td align="right">1H 5M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">吃好吃</td>
<td align="left">外食🍱</td>
<td align="right">46M 58S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">添加網絡日誌</td>
<td align="left">寫code⌨️</td>
<td align="right">1H 16M 17S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">整理toggl時間統計</td>
<td align="left">寫code⌨️</td>
<td align="right">10M 42S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">How ReGenesess Calibration Works</td>
<td align="left">學習</td>
<td align="right">54M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">How Reddit Ranking Works</td>
<td align="left">學習</td>
<td align="right">25M 22S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">37M 14S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">去吃好吃</td>
<td align="left">走路👣</td>
<td align="right">11M 31S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">去中心</td>
<td align="left">走路👣</td>
<td align="right">10M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">BU Training</td>
<td align="left">Biogen-Misc</td>
<td align="right">29M 7S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">AAN Expense Report</td>
<td align="left">Biogen-Misc</td>
<td align="right">29M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">57M 42S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">How to read PDF in to R</td>
<td align="left">上網打混😝</td>
<td align="right">32M 51S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">打混，亂看</td>
<td align="left">上網打混😝</td>
<td align="right">4M 17S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">早飯</td>
<td align="left">做飯🥘</td>
<td align="right">18M 16S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">讀『奇特的一生』</td>
<td align="left">看書📗</td>
<td align="right">10M 7S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">10M 2S</td>
</tr>
<tr class="even">
<td align="left">2017-05-06</td>
<td align="left">整理房間</td>
<td align="left">打掃🏡</td>
<td align="right">8M 23S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-06</td>
<td align="left">吃早飯</td>
<td align="left">吃飯🍚</td>
<td align="right">5M 43S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">Revising Biometrics Paper</td>
<td align="left">寫code⌨️</td>
<td align="right">2H 20M 28S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">敲網誌</td>
<td align="left">寫code⌨️</td>
<td align="right">23M 41S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">和彭痛Skype</td>
<td align="left">聯繫</td>
<td align="right">2H 39M 35S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">吃午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">31M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">吃晚飯</td>
<td align="left">吃飯🍚</td>
<td align="right">18M 41S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">吃早飯</td>
<td align="left">吃飯🍚</td>
<td align="right">12M 8S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">43M 57S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">鐵</td>
<td align="left">運動🏀</td>
<td align="right">7M 45S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">44M 30S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">從吹得兒宙到H市場</td>
<td align="left">開車🚗</td>
<td align="right">15M 54S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">回家</td>
<td align="left">開車🚗</td>
<td align="right">13M 22S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">去吹得兒宙</td>
<td align="left">開車🚗</td>
<td align="right">12M 16S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">去公司健身房</td>
<td align="left">走路👣</td>
<td align="right">17M 59S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">15M 48S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">做午飯</td>
<td align="left">做飯🥘</td>
<td align="right">20M 51S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">做早飯</td>
<td align="left">做飯🥘</td>
<td align="right">8M 3S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">逛吹得兒宙</td>
<td align="left">購物🛒</td>
<td align="right">14M 45S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">逛H市場</td>
<td align="left">購物🛒</td>
<td align="right">12M 15S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">整理廚房</td>
<td align="left">打掃🏡</td>
<td align="right">14M 18S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-07</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">10M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-07</td>
<td align="left">刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">3M 3S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">5H 6M 18S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">review of concepts</td>
<td align="left">Biogen-常規</td>
<td align="right">51M 50S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">36M 57S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">skype郎廣明</td>
<td align="left">聯繫</td>
<td align="right">1H 21M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">skype 彭痛</td>
<td align="left">聯繫</td>
<td align="right">1H 1M 44S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">吃晚飯</td>
<td align="left">吃飯🍚</td>
<td align="right">32M 33S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">吃午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">25M 11S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">吃早飯</td>
<td align="left">吃飯🍚</td>
<td align="right">10M 39S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">敲網誌</td>
<td align="left">上網打混😝</td>
<td align="right">36M 10S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">刷手機</td>
<td align="left">上網打混😝</td>
<td align="right">27M 44S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">39M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">21M 28S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">11M 52S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">做晚飯</td>
<td align="left">做飯🥘</td>
<td align="right">8M 18S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-08</td>
<td align="left">call help desk</td>
<td align="left">Biogen-Misc</td>
<td align="right">6M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-05-08</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">4M 11S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">review of concepts</td>
<td align="left">Biogen-常規</td>
<td align="right">2H 9M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">sample size for McNemar</td>
<td align="left">學習</td>
<td align="right">2H 5M 56S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">買頭盔和種子</td>
<td align="left">購物🛒</td>
<td align="right">55M 33S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">skype 彭痛</td>
<td align="left">聯繫</td>
<td align="right">53M 25S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">31M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">15M 38S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">做晚飯</td>
<td align="left">做飯🥘</td>
<td align="right">43M 38S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">吃午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">27M 37S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">6M 10S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">28M 2S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">20M 26S</td>
</tr>
<tr class="even">
<td align="left">2017-05-09</td>
<td align="left">刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">6M 16S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-09</td>
<td align="left">大便</td>
<td align="left">Biogen-Misc</td>
<td align="right">15M 21S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">skype彭</td>
<td align="left">聯繫</td>
<td align="right">1H 54M 4S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">ESTEEM abstract review</td>
<td align="left">Biogen-常規</td>
<td align="right">53M 27S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">27M 45S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">lymphocytes counts</td>
<td align="left">Biogen-常規</td>
<td align="right">26M 43S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">30M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">理髮</td>
<td align="left">洗漱🛁</td>
<td align="right">25M 20S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">刷牙洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">23M 16S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">38M 17S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">回公司</td>
<td align="left">走路👣</td>
<td align="right">16M 29S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">13M 56S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">去理髮</td>
<td align="left">走路👣</td>
<td align="right">8M 34S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">吃午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">38M 48S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">吃早飯</td>
<td align="left">吃飯🍚</td>
<td align="right">17M 33S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">看RMS</td>
<td align="left">學習</td>
<td align="right">47M 26S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">賴床</td>
<td align="left">上網打混😝</td>
<td align="right">39M 4S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-10</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">32M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-10</td>
<td align="left">大便</td>
<td align="left">Biogen-Misc</td>
<td align="right">11M 58S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 36M 23S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">touch base</td>
<td align="left">Biogen-常規</td>
<td align="right">40M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">lymphocytes counts</td>
<td align="left">Biogen-常規</td>
<td align="right">35M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">MSPATH</td>
<td align="left">Biogen-拓展</td>
<td align="right">1H 36M 1S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">去買腳踏車</td>
<td align="left">走路👣</td>
<td align="right">1H 8M 54S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">14M 23S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">skype彭</td>
<td align="left">聯繫</td>
<td align="right">45M 8S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">聯繫瓜</td>
<td align="left">聯繫</td>
<td align="right">29M 33S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">吃完飯</td>
<td align="left">吃飯🍚</td>
<td align="right">40M 6S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">吃早飯</td>
<td align="left">吃飯🍚</td>
<td align="right">10M 10S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">做晚飯</td>
<td align="left">做飯🥘</td>
<td align="right">41M 3S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">31M 25S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">看紀錄片</td>
<td align="left">上網打混😝</td>
<td align="right">18M 20S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">大便</td>
<td align="left">上網打混😝</td>
<td align="right">9M 56S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">23M 27S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">3M 31S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-11</td>
<td align="left">吃茄子三明治</td>
<td align="left">外食🍱</td>
<td align="right">19M 5S</td>
</tr>
<tr class="even">
<td align="left">2017-05-11</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">18M 54S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">等看醫生</td>
<td align="left">發呆</td>
<td align="right">2H 59M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">看修水管</td>
<td align="left">發呆</td>
<td align="right">1H 0M 1S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">等止血</td>
<td align="left">發呆</td>
<td align="right">10M 54S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">Skype chen</td>
<td align="left">聯繫</td>
<td align="right">1H 0M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">吃剩飯</td>
<td align="left">吃飯🍚</td>
<td align="right">33M 38S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">12M 4S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">22M 9S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">去中心</td>
<td align="left">走路👣</td>
<td align="right">15M 50S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">36M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">讀Mind's I</td>
<td align="left">看書📗</td>
<td align="right">36M 21S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">吃煎餅果子</td>
<td align="left">外食🍱</td>
<td align="right">35M 43S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">坐地鐵去MGH</td>
<td align="left">公交🚌</td>
<td align="right">29M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">種花</td>
<td align="left">打掃🏡</td>
<td align="right">27M 56S</td>
</tr>
<tr class="even">
<td align="left">2017-05-12</td>
<td align="left">逛二手店</td>
<td align="left">購物🛒</td>
<td align="right">24M 31S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-12</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">19M 4S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">剃莎莎</td>
<td align="left">打掃🏡</td>
<td align="right">3H 10M 9S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">13M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">亂晃騎車</td>
<td align="left">發呆</td>
<td align="right">1H 5M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">彈吉他</td>
<td align="left">發呆</td>
<td align="right">43M 35S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">亂上網</td>
<td align="left">上網打混😝</td>
<td align="right">50M 45S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">吃炒麵</td>
<td align="left">吃飯🍚</td>
<td align="right">28M 37S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">16M 51S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">改biometrics paper</td>
<td align="left">寫code⌨️</td>
<td align="right">41M 42S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">37M 8S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">Skype chen</td>
<td align="left">聯繫</td>
<td align="right">34M 18S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">吃Maine tomato sandwich</td>
<td align="left">外食🍱</td>
<td align="right">28M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">做午飯</td>
<td align="left">做飯🥘</td>
<td align="right">25M 41S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">看《沉默的大多數》</td>
<td align="left">看書📗</td>
<td align="right">25M 18S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">18M 23S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">5M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-13</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">7M 7S</td>
</tr>
<tr class="even">
<td align="left">2017-05-13</td>
<td align="left">去clover</td>
<td align="left">走路👣</td>
<td align="right">6M 35S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">改biometrics paper</td>
<td align="left">寫code⌨️</td>
<td align="right">1H 22M 42S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">回家拿錢包</td>
<td align="left">開車🚗</td>
<td align="right">24M 58S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">拿菜回家</td>
<td align="left">開車🚗</td>
<td align="right">11M 45S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">去吹得兒宙</td>
<td align="left">開車🚗</td>
<td align="right">10M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">吃速凍炒飯</td>
<td align="left">吃飯🍚</td>
<td align="right">25M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">吃餅</td>
<td align="left">吃飯🍚</td>
<td align="right">13M 45S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">減肥A</td>
<td align="left">運動🏀</td>
<td align="right">36M 1S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">34M 46S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">買菜</td>
<td align="left">購物🛒</td>
<td align="right">21M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">19M 13S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-14</td>
<td align="left">做速凍炒飯</td>
<td align="left">做飯🥘</td>
<td align="right">9M 58S</td>
</tr>
<tr class="even">
<td align="left">2017-05-14</td>
<td align="left">煎蔥油餅</td>
<td align="left">做飯🥘</td>
<td align="right">8M 24S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">BSAP</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 0M 21S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">55M 34S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">看bookdown</td>
<td align="left">學習</td>
<td align="right">1H 0M 42S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">S3 method in R</td>
<td align="left">學習</td>
<td align="right">10M 30S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">吃米飯</td>
<td align="left">吃飯🍚</td>
<td align="right">30M 45S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">吃炒飯</td>
<td align="left">吃飯🍚</td>
<td align="right">21M 5S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">10M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">看propensity score</td>
<td align="left">Biogen-拓展</td>
<td align="right">46M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">17M 7S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">14M 58S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">29M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">看眼睛</td>
<td align="left">發呆</td>
<td align="right">27M 53S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">18M 58S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">6M 26S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">做熊市炒雞蛋</td>
<td align="left">做飯🥘</td>
<td align="right">25M 5S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">13M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-15</td>
<td align="left">亂刷手機</td>
<td align="left">上網打混😝</td>
<td align="right">12M 1S</td>
</tr>
<tr class="even">
<td align="left">2017-05-15</td>
<td align="left">回家</td>
<td align="left">騎車🚲</td>
<td align="right">7M 3S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">2H 14M 11S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">看GUI report</td>
<td align="left">Biogen-常規</td>
<td align="right">17M 58S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">喝小米粥</td>
<td align="left">吃飯🍚</td>
<td align="right">27M 3S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">吃午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">22M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">11M 20S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">做小米粥</td>
<td align="left">做飯🥘</td>
<td align="right">39M 46S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">34M 4S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">33M 19S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">回家</td>
<td align="left">騎車🚲</td>
<td align="right">13M 29S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">去公司</td>
<td align="left">騎車🚲</td>
<td align="right">7M 28S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-16</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">12M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-16</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">3M 52S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">3H 26M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">2H 1M 16S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">Skype chen</td>
<td align="left">聯繫</td>
<td align="right">1H 9M 41S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">修水管</td>
<td align="left">打掃🏡</td>
<td align="right">55M 46S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">52M 6S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">吃湯面</td>
<td align="left">吃飯🍚</td>
<td align="right">23M 26S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">吃剩飯</td>
<td align="left">吃飯🍚</td>
<td align="right">21M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">5M 41S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">35M 6S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">34M 44S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">回家</td>
<td align="left">騎車🚲</td>
<td align="right">11M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">回公司</td>
<td align="left">騎車🚲</td>
<td align="right">9M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">去公司</td>
<td align="left">騎車🚲</td>
<td align="right">8M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">回家吃飯</td>
<td align="left">騎車🚲</td>
<td align="right">5M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-17</td>
<td align="left">做麵吃</td>
<td align="left">做飯🥘</td>
<td align="right">24M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-17</td>
<td align="left">MSPATH</td>
<td align="left">Biogen-拓展</td>
<td align="right">18M 21S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-18</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">4H 45M 11S</td>
</tr>
<tr class="even">
<td align="left">2017-05-18</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">40M 51S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-18</td>
<td align="left">Sweden survey project</td>
<td align="left">寫code⌨️</td>
<td align="right">1H 15M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-18</td>
<td align="left">熱飯吃飯</td>
<td align="left">吃飯🍚</td>
<td align="right">18M 40S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-18</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">9M 9S</td>
</tr>
<tr class="even">
<td align="left">2017-05-18</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">26M 47S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-18</td>
<td align="left">去公司</td>
<td align="left">騎車🚲</td>
<td align="right">9M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-18</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">6M 41S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-19</td>
<td align="left">聽講座</td>
<td align="left">Biogen-拓展</td>
<td align="right">1H 59M 49S</td>
</tr>
<tr class="even">
<td align="left">2017-05-19</td>
<td align="left">MSPATH</td>
<td align="left">Biogen-拓展</td>
<td align="right">33M 5S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-19</td>
<td align="left">吃馕喝粥</td>
<td align="left">吃飯🍚</td>
<td align="right">1H 22M 44S</td>
</tr>
<tr class="even">
<td align="left">2017-05-19</td>
<td align="left">吃沙拉</td>
<td align="left">吃飯🍚</td>
<td align="right">31M 10S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-19</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 27M 35S</td>
</tr>
<tr class="even">
<td align="left">2017-05-19</td>
<td align="left">讀paper</td>
<td align="left">學習</td>
<td align="right">34M 37S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-19</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">18M 39S</td>
</tr>
<tr class="even">
<td align="left">2017-05-19</td>
<td align="left">做馕</td>
<td align="left">做飯🥘</td>
<td align="right">17M 38S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-20</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">3H 23M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-20</td>
<td align="left">開車回家</td>
<td align="left">開車🚗</td>
<td align="right">59M 20S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-20</td>
<td align="left">開車取畫</td>
<td align="left">開車🚗</td>
<td align="right">42M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-20</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">56M 16S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-20</td>
<td align="left">Zoe</td>
<td align="left">外食🍱</td>
<td align="right">40M 45S</td>
</tr>
<tr class="even">
<td align="left">2017-05-20</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">24M 15S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-20</td>
<td align="left">skype彭</td>
<td align="left">聯繫</td>
<td align="right">20M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-20</td>
<td align="left">吃速凍麵</td>
<td align="left">吃飯🍚</td>
<td align="right">19M 33S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-20</td>
<td align="left">做速凍麵</td>
<td align="left">做飯🥘</td>
<td align="right">10M 9S</td>
</tr>
<tr class="even">
<td align="left">2017-05-21</td>
<td align="left">郎廣明project</td>
<td align="left">寫code⌨️</td>
<td align="right">1H 53M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-21</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">56M 59S</td>
</tr>
<tr class="even">
<td align="left">2017-05-21</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">51M 31S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">2H 34M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">改biometrics paper</td>
<td align="left">寫code⌨️</td>
<td align="right">2H 32M 40S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">MSPATH</td>
<td align="left">Biogen-拓展</td>
<td align="right">1H 24M 57S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">看paper</td>
<td align="left">Biogen-拓展</td>
<td align="right">55M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">RMS</td>
<td align="left">學習</td>
<td align="right">1H 5M 35S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">Swann's Way</td>
<td align="left">看書📗</td>
<td align="right">55M 31S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">百健午飯</td>
<td align="left">吃飯🍚</td>
<td align="right">41M 37S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">喝巧克力</td>
<td align="left">吃飯🍚</td>
<td align="right">12M 8S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">skype彭</td>
<td align="left">聯繫</td>
<td align="right">45M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">做米飯</td>
<td align="left">做飯🥘</td>
<td align="right">38M 30S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">33M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">16M 4S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">去百健</td>
<td align="left">走路👣</td>
<td align="right">15M 19S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">18M 55S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-22</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">8M 30S</td>
</tr>
<tr class="even">
<td align="left">2017-05-22</td>
<td align="left">洗碗</td>
<td align="left">打掃🏡</td>
<td align="right">10M 53S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">109HV321</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 35M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 0M 27S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">proofreading biometrics paper</td>
<td align="left">寫作</td>
<td align="right">2H 25M 45S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">MSPATH</td>
<td align="left">Biogen-拓展</td>
<td align="right">1H 2M 32S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">marginal Cox model</td>
<td align="left">Biogen-拓展</td>
<td align="right">28M 7S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">吃包子</td>
<td align="left">外食🍱</td>
<td align="right">1H 22M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">吃剩飯</td>
<td align="left">吃飯🍚</td>
<td align="right">45M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">24M 10S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">54M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">48M 39S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">line宸</td>
<td align="left">聯繫</td>
<td align="right">42M 16S</td>
</tr>
<tr class="even">
<td align="left">2017-05-23</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">14M 54S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-23</td>
<td align="left">洗臉刷牙</td>
<td align="left">洗漱🛁</td>
<td align="right">5M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-24</td>
<td align="left">RMS</td>
<td align="left">學習</td>
<td align="right">1H 33M 30S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-24</td>
<td align="left">讀RMS</td>
<td align="left">學習</td>
<td align="right">1H 3M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-24</td>
<td align="left">proofreading biometrics paper</td>
<td align="left">寫作</td>
<td align="right">1H 40M 46S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-24</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">53M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-24</td>
<td align="left">看protocol</td>
<td align="left">Biogen-常規</td>
<td align="right">33M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-24</td>
<td align="left">聽talk</td>
<td align="left">Biogen-Misc</td>
<td align="right">59M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-24</td>
<td align="left">吃剩飯</td>
<td align="left">吃飯🍚</td>
<td align="right">28M 57S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-24</td>
<td align="left">吃免費飯</td>
<td align="left">吃飯🍚</td>
<td align="right">20M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-24</td>
<td align="left">line宸</td>
<td align="left">聯繫</td>
<td align="right">45M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-24</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">31M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">讀205MS235 protocol</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 21M 49S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">lymphocytes count chart review</td>
<td align="left">Biogen-常規</td>
<td align="right">51M 27S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">44M 49S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">回郵件</td>
<td align="left">Biogen-常規</td>
<td align="right">16M 17S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">8M 23S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">RMS</td>
<td align="left">學習</td>
<td align="right">1H 1M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">53M 35S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">吃速凍飯</td>
<td align="left">吃飯🍚</td>
<td align="right">38M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">8M 13S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">29M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">14M 14S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-25</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">33M 12S</td>
</tr>
<tr class="even">
<td align="left">2017-05-25</td>
<td align="left">做速凍飯</td>
<td align="left">做飯🥘</td>
<td align="right">19M 5S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">看醫生</td>
<td align="left">發呆</td>
<td align="right">2H 25M 46S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">19M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">回家</td>
<td align="left">走路👣</td>
<td align="right">1H 31M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">去公司</td>
<td align="left">走路👣</td>
<td align="right">14M 7S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 44M 41S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">亂上網</td>
<td align="left">上網打混😝</td>
<td align="right">1H 8M 52S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">刷手機</td>
<td align="left">上網打混😝</td>
<td align="right">31M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">煎餅果子</td>
<td align="left">外食🍱</td>
<td align="right">1H 14M 16S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">Swann's Way</td>
<td align="left">看書📗</td>
<td align="right">1H 8M 18S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">做土豆絲</td>
<td align="left">做飯🥘</td>
<td align="right">51M 26S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">吃飯</td>
<td align="left">吃飯🍚</td>
<td align="right">31M 9S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">11M 47S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">27M 30S</td>
</tr>
<tr class="even">
<td align="left">2017-05-26</td>
<td align="left">去MGH</td>
<td align="left">公交🚌</td>
<td align="right">18M 28S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-26</td>
<td align="left">微信宸</td>
<td align="left">聯繫</td>
<td align="right">6M 54S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">洗衣服 收拾房間</td>
<td align="left">打掃🏡</td>
<td align="right">1H 36M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-27</td>
<td align="left">疊衣服</td>
<td align="left">打掃🏡</td>
<td align="right">11M 50S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">喝粥</td>
<td align="left">吃飯🍚</td>
<td align="right">1H 4M 6S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-27</td>
<td align="left">吃麵包</td>
<td align="left">吃飯🍚</td>
<td align="right">26M 43S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">吃剩飯</td>
<td align="left">吃飯🍚</td>
<td align="right">14M 19S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-27</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">1H 34M 50S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">30M 8S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-27</td>
<td align="left">Swann's Way</td>
<td align="left">看書📗</td>
<td align="right">28M 44S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">做稀飯</td>
<td align="left">做飯🥘</td>
<td align="right">28M 2S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-27</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">22M 31S</td>
</tr>
<tr class="even">
<td align="left">2017-05-27</td>
<td align="left">跑圈</td>
<td align="left">運動🏀</td>
<td align="right">15M 7S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-28</td>
<td align="left">看電影</td>
<td align="left">娛樂</td>
<td align="right">2H 28M 55S</td>
</tr>
<tr class="even">
<td align="left">2017-05-28</td>
<td align="left">讀RMS</td>
<td align="left">學習</td>
<td align="right">2H 9M 2S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-28</td>
<td align="left">Swann's Way</td>
<td align="left">看書📗</td>
<td align="right">1H 27M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-28</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">1H 13M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-28</td>
<td align="left">吃麵包</td>
<td align="left">吃飯🍚</td>
<td align="right">31M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-05-28</td>
<td align="left">吃餅乾</td>
<td align="left">吃飯🍚</td>
<td align="right">22M 3S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-28</td>
<td align="left">吃幫蜜</td>
<td align="left">吃飯🍚</td>
<td align="right">11M 10S</td>
</tr>
<tr class="even">
<td align="left">2017-05-28</td>
<td align="left">去吹得兒宙買菜</td>
<td align="left">購物🛒</td>
<td align="right">43M 43S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-28</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">35M 28S</td>
</tr>
<tr class="even">
<td align="left">2017-05-28</td>
<td align="left">做三杯</td>
<td align="left">做飯🥘</td>
<td align="right">17M 10S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-29</td>
<td align="left">看驢得水</td>
<td align="left">娛樂</td>
<td align="right">1H 31M 13S</td>
</tr>
<tr class="even">
<td align="left">2017-05-29</td>
<td align="left">observational studies</td>
<td align="left">學習</td>
<td align="right">1H 29M 5S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-29</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">1H 6M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-29</td>
<td align="left">做糯米粥</td>
<td align="left">做飯🥘</td>
<td align="right">31M 46S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-29</td>
<td align="left">做湯麵</td>
<td align="left">做飯🥘</td>
<td align="right">15M 12S</td>
</tr>
<tr class="even">
<td align="left">2017-05-30</td>
<td align="left">109HV321</td>
<td align="left">Biogen-常規</td>
<td align="right">3H 24M 45S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-30</td>
<td align="left">sustain meetings</td>
<td align="left">Biogen-常規</td>
<td align="right">51M 12S</td>
</tr>
<tr class="even">
<td align="left">2017-05-30</td>
<td align="left">109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">42M 22S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-30</td>
<td align="left">109MS406 meeting</td>
<td align="left">Biogen-常規</td>
<td align="right">38M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-30</td>
<td align="left">修車+午飯</td>
<td align="left">外食🍱</td>
<td align="right">1H 35M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-30</td>
<td align="left">BU training</td>
<td align="left">Biogen-Misc</td>
<td align="right">55M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-05-30</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">32M 6S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-30</td>
<td align="left">observational studies</td>
<td align="left">學習</td>
<td align="right">9M 53S</td>
</tr>
<tr class="even">
<td align="left">2017-05-30</td>
<td align="left">喝燕麥粥</td>
<td align="left">吃飯🍚</td>
<td align="right">7M 43S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">讀205MS235 protocol</td>
<td align="left">Biogen-常規</td>
<td align="right">53M 40S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">touch base</td>
<td align="left">Biogen-常規</td>
<td align="right">30M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">TLG for plots 109MS406</td>
<td align="left">Biogen-常規</td>
<td align="right">25M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">1H 2M 44S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">回家吃飯</td>
<td align="left">吃飯🍚</td>
<td align="right">1H 2M 39S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">observational studies</td>
<td align="left">學習</td>
<td align="right">55M 42S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">BU training</td>
<td align="left">Biogen-Misc</td>
<td align="right">51M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">跑步</td>
<td align="left">運動🏀</td>
<td align="right">48M 3S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">寫 PS guidelines</td>
<td align="left">Biogen-拓展</td>
<td align="right">45M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">微信宸</td>
<td align="left">聯繫</td>
<td align="right">30M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-05-31</td>
<td align="left">做煎餃</td>
<td align="left">做飯🥘</td>
<td align="right">19M 48S</td>
</tr>
<tr class="even">
<td align="left">2017-05-31</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">14M 34S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-01</td>
<td align="left">讀 ESTEEM MSBase SAP</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 20M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-06-01</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">57M 15S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-01</td>
<td align="left">TLG 321</td>
<td align="left">Biogen-常規</td>
<td align="right">25M 32S</td>
</tr>
<tr class="even">
<td align="left">2017-06-01</td>
<td align="left">讀 Causal Inference</td>
<td align="left">學習</td>
<td align="right">1H 43M 19S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-01</td>
<td align="left">亂晃</td>
<td align="left">發呆</td>
<td align="right">1H 14M 4S</td>
</tr>
<tr class="even">
<td align="left">2017-06-01</td>
<td align="left">吃Bio 6</td>
<td align="left">外食🍱</td>
<td align="right">59M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-01</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">37M 52S</td>
</tr>
<tr class="even">
<td align="left">2017-06-01</td>
<td align="left">喝燕麥片</td>
<td align="left">吃飯🍚</td>
<td align="right">9M 59S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-01</td>
<td align="left">刷牙洗臉</td>
<td align="left">洗漱🛁</td>
<td align="right">8M 5S</td>
</tr>
<tr class="even">
<td align="left">2017-06-02</td>
<td align="left">吃百健餐廳</td>
<td align="left">吃飯🍚</td>
<td align="right">55M 0S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-02</td>
<td align="left">吃速凍飯</td>
<td align="left">吃飯🍚</td>
<td align="right">27M 43S</td>
</tr>
<tr class="even">
<td align="left">2017-06-02</td>
<td align="left">analysis of count data</td>
<td align="left">學習</td>
<td align="right">1H 21M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-02</td>
<td align="left">開會</td>
<td align="left">Biogen-常規</td>
<td align="right">1H 19M 10S</td>
</tr>
<tr class="even">
<td align="left">2017-06-02</td>
<td align="left">diagrammeR</td>
<td align="left">上網打混😝</td>
<td align="right">53M 12S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-02</td>
<td align="left">Skype 宸</td>
<td align="left">聯繫</td>
<td align="right">37M 0S</td>
</tr>
<tr class="even">
<td align="left">2017-06-02</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">33M 9S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-02</td>
<td align="left">Swann's way</td>
<td align="left">看書📗</td>
<td align="right">32M 34S</td>
</tr>
<tr class="even">
<td align="left">2017-06-02</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">20M 53S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-02</td>
<td align="left">做速凍飯</td>
<td align="left">做飯🥘</td>
<td align="right">13M 57S</td>
</tr>
<tr class="even">
<td align="left">2017-06-03</td>
<td align="left">洗澡</td>
<td align="left">洗漱🛁</td>
<td align="right">1H 35M 29S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-03</td>
<td align="left">微信起義</td>
<td align="left">聯繫</td>
<td align="right">1H 10M 36S</td>
</tr>
<tr class="even">
<td align="left">2017-06-03</td>
<td align="left">吃仏和米</td>
<td align="left">外食🍱</td>
<td align="right">43M 14S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-03</td>
<td align="left">吃幫蜜</td>
<td align="left">外食🍱</td>
<td align="right">23M 24S</td>
</tr>
<tr class="even">
<td align="left">2017-06-03</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">44M 5S</td>
</tr>
<tr class="odd">
<td align="left">2017-06-04</td>
<td align="left">走莎莎</td>
<td align="left">遛狗🐶</td>
<td align="right">45M 59S</td>
</tr>
</tbody>
</table>

    # "🍱"
