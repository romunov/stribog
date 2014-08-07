# Uvoz podatkov kriminalitete iz leta 2001

setwd("./stribog/rawdata")

leto <- "2001"
fn <- paste("kd", leto, sep = "")
dir.create(fn)
unzip(paste("./", fn, ".zip", sep = ""), exdir = "./kd2001")

infiles <- list.files(paste("./", fn, sep = ""), full.names = TRUE)
infiles
# all possible encodings 
#iconvlist() # brute force attack je razkril "WINDOWS-1250" kot najbolj primerno glede šumnikov et al

kd <- read.table(infiles[grepl("KDINTKD\\.txt", infiles)], header = FALSE, sep = "$", fileEncoding = "windows-1250", encoding = "UTF8")
kdo <- read.table(infiles[grepl("KDINTKDO\\.txt", infiles)], header = FALSE, sep = "$", fileEncoding = "windows-1250", encoding = "UTF8")

# spucaj šifrant
sif <- readLines(infiles[grepl("ifranti\\.txt", infiles)], encoding = "WINDOWS-1250")

# struktura baze, glej navodila_kriminaliteta.pdf
names(kd) <- c(
   "st",                 #1
   "datum",              #2
   "ura",                #3
   "dan",                #4
   "pu",                 #5
   "povratnik",          #6
   "klasifikacija_kd",   #7
   "poglavje_zakonika",  #8
   "gospodarska_k",      #9
   "organizirana_k",     #10
   "mladoletniška_k",    #11
   "dokoncnost",         #12
   ""
   )