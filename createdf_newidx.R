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
  thenames
}