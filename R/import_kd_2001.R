# Uvoz podatkov kriminalitete iz leta 2001

setwd("./stribog/rawdata")

leto <- "2001"
fn <- paste("kd", leto, sep = "")
dir.create(fn)
unzip(paste("./", fn, ".zip", sep = ""), exdir = "./kd2001")

infiles <- list.files(paste("./", fn, sep = ""), full.names = TRUE)

# all possible encodings 
#iconvlist() # brute force attack je razkril "WINDOWS-1250" kot najbolj primerno glede šumnikov et al

kd <- read.table(infiles[grepl("KDINTKD\\.txt", infiles)], header = FALSE, sep = "$", fileEncoding = "WINDOWS-1250")
kdo <- read.table(infiles[grepl("KDINTKDO\\.txt", infiles)], header = FALSE, sep = "$", fileEncoding = "WINDOWS-1250")
sif <- read.table(infiles[grepl("ifranti\\.txt", infiles)], header = FALSE, sep = "$")

# takole sem jaz probal na silo, pa ni vrglo ven pravega
sif2 <- readLines("./pn2013/SIFRANTI.TXT")
mm <- sapply(iconvlist(), FUN = function(x) {
      out <- tryCatch(
         iconv(sif2, from = x, to = "UTF8"), error = function(e) "fak")
      out[1:2]
   })
write.csv(t(mm), file="possibleEncodings.txt")
# Crt: sem probal še sam iz firbca in (na SIFRANTI.TXT v folderju /rawdata/pn2013) in sem dobil dva kandidata:
# "MS-EE"
# "WINDOWS-1250"