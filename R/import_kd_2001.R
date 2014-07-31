# Uvoz podatkov kriminalitete iz leta 2001

setwd("./stribog/rawdata")

leto <- "2001"
fn <- paste("kd", leto, sep = "")
dir.create(fn)
unzip(paste("./", fn, ".zip", sep = ""), exdir = "./kd2001")

infiles <- list.files(paste("./", fn, sep = ""), full.names = TRUE)

kd <- read.table(infiles[grepl("KDINTKD\\.txt", infiles)], header = FALSE, sep = "$")
kdo <- read.table(infiles[grepl("KDINTKDO\\.txt", infiles)], header = FALSE, sep = "$")
sif <- read.table(infiles[grepl("ifranti\\.txt", infiles)], header = FALSE, sep = "$")