library(bigrquery)

BQ_download_table <- function(table, dataset = '82421188'){
  project <- "ecg-nl"
  list_tabledata(project, dataset, table, page_size = 10000, table_info = NULL, max_pages = Inf, warn = TRUE)
}

AUR3848_TP_T <- BQ_download_table('AUR3848_TP_T')

write.csv(AUR3848_TP_T,'AUR3848_TP_T.csv')

BQ_TTEST <- function(ticket_number){
     
     SRP_Search <- t.test (ticket_number$SRP_Search ~ ticket_number$abgroup)
     SRP_Browse <- t.test (ticket_number$SRP_Browse ~ ticket_number$abgroup)
     L1Page <- t.test (ticket_number$L1Page ~ ticket_number$abgroup)
     VIP <- t.test (ticket_number$VIP ~ ticket_number$abgroup)
     VIP_Admarkt <- t.test (ticket_number$VIP_Admarkt ~ ticket_number$abgroup)
     VIP_Regular <- t.test (ticket_number$VIP_Regular ~ ticket_number$abgroup)
     URL <- t.test (ticket_number$URL ~ ticket_number$abgroup)
     Lead_w_url <- t.test (ticket_number$Lead_w_url ~ ticket_number$abgroup)
     Lead <- t.test (ticket_number$Lead ~ ticket_number$abgroup)
     View <- t.test (ticket_number$View ~ ticket_number$abgroup)
     Time_on_site <- t.test (ticket_number$Time_on_site ~ ticket_number$abgroup)
     Homepage <- t.test (ticket_number$Homepage ~ ticket_number$abgroup)
     
     list(SRP_Search, SRP_Browse, L1Page, VIP, VIP_Admarkt, VIP_Regular, URL, Lead_w_url, Lead, View, Time_on_site, Homepage) 
}

BQ_TTEST(AUR3848_TP_T)

summary(AUR3848_TP_T)

AUR3848_TP_T2 <- subset(AUR3848_TP_T, date %in% c('20171129', '20171130', '20171201', '20171202', '20171203', '20171204', '20171205'))

