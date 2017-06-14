library(iterpc)
library(dplyr)
library(phonics)

create.df <- function(names){
  theidx = 0
  total.names <- sum(sapply(names, length))

  add.index <- function(curnames){
    theidx <<- theidx + 1
    data.frame(names = curnames,
               idx = theidx)
  }
  
  I <- iterpc(total.names, 2, replace = TRUE)
  ord <- getall(I)
  
  thenames <- rbind(ldply(names, add.index))
  
  thenames <- cbind(thenames[ord[,1],], thenames[ord[,2],])
  colnames(thenames)[c(1,3)] <- c("name1", "name2")
  thenames$match <- thenames[,2] == thenames[,4]
  thenames <- thenames[c(1,3,5)]
  thenames$nlen1 <- apply(thenames,2,nchar)[,1]
  thenames$nlen2 <- apply(thenames,2,nchar)[,2]
  thenames$d_len <- thenames$nlen1 - thenames$nlen2
  thenames$abs_d_len <- abs(thenames$d_len)
  thenames$fchar1 <- substring(thenames$name1, 1, 1)
  thenames$fchar2 <- substring(thenames$name2, 1, 1)
  thenames$d_fchar = as.factor(thenames$fchar1 == thenames$fchar2)
  thenames <- mutate(thenames, d_sdx = stringdist(name1, name2, method = "soundex"))
  thenames <- mutate(thenames, cos_d = stringdist(name1, name2, method = "cosine", q = 2))
  thenames
}