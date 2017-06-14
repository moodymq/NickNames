fileName <- "/home/moodymq/Documents/names.csv"
rawnames <- readChar(fileName, file.info(fileName)$size)
thenames <- strsplit(unlist(strsplit(rawnames, split = "\n")), split = ",")
#mynames <- thenames[1:10]
names.db <- create.df(thenames[1:100])
names.db$match <- as.factor(names.db$match)