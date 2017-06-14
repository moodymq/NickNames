library(caret)
library(dplyr)

working.db <- select(names.db, match, d_len, abs_d_len, d_fchar, d_sdx, cos_d)


inTrain <- createDataPartition(working.db$match, p = .6, list = FALSE)
training <- working.db[inTrain,]
test <- working.db[-inTrain,]

rf_model <- train(#x = training[,-which(colnames(training) == c("name1", "name2", "match"))],
                  #y = factor(training$match),
                  form = match ~ .,
                  data = training,
                  method = "rf",
                  prox = FALSE,
                  allowParallel = TRUE)

