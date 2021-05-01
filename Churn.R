install.packages("caret")
install.packages('e1071', dependencies=TRUE)
install.packages("ROCR")
install.packages("rlang")


#Read data into R
churn_input<-read.csv("C:/Users/valay/OneDrive/Desktop/Ivey/Winter Term 2021/Big Data Analytics/Final Exam/BDA Final Data - telecom_churn_data_sim.csv")
#Look at data. (Note: Mostly using same notation as text to make it easier to follow
head(churn_input)

#Logistic output. (Note this is after trying different models.)
Churn_logistic3 <- glm (churn~aon +revenue_8 +onnet_mou_8 +offnet_mou_8 +roam_ic_mou_8 +roam_og_mou_8 +loc_og_mou_8 +std_og_mou_8 +isd_og_mou_8 +total_og_mou_8 +loc_ic_mou_8 +std_ic_mou_8 +isd_ic_mou_8 +total_ic_mou_8 +total_og_to_ic_mou_8 +loc_og_to_ic_mou_8 +roam_og_to_ic_mou_8 +std_og_to_ic_mou_8 +isd_og_to_ic_mou_8 +vol_4g_8 +vol_3g_8 +total_vol_8 , data=churn_input, family=binomial(link="logit"))
summary(Churn_logistic3)

Churn_logistic4 <- glm (churn~aon +onnet_mou_8 +offnet_mou_8 +roam_og_mou_8 +total_og_mou_8 +loc_ic_mou_8 +std_ic_mou_8 +isd_ic_mou_8 +vol_4g_8 +vol_3g_8, data=churn_input, family=binomial(link="logit"))
summary(Churn_logistic4)

#use predict() with type = "response" to compute predicted probabilities.
#Displaying Actual and Predicted Probability together
pred <- predict(Churn_logistic4 , churn_input, type = "response")
head(pred)


classification <- ifelse(pred>0.35, 1, 0)
actual = churn_input$churn

Output <- data.frame(actual, predprob=pred, classification)
head(Output)

library(caret)
confusionMatrix(as.factor(classification), as.factor(actual))
library(ROCR)
#Choose a threshold and classify records

predObj <- prediction(pred, churn_input$churn)

rocObj = performance(predObj, measure="tpr", x.measure="fpr")
aucObj = performance(predObj, measure="auc")  

plot(rocObj, main = paste("Area under the curve:", round(aucObj@y.values[[1]] ,4)))


-------------------------------------------------------------------------------------------------
  
library(e1071)

#point of Naive Bayes is determine if x is more likely than y

# Create training and validation sets
#these numbers correspond to the variables you want (numbered by order of variables)
#these variables are only from significant p-values from the logistic regression
selected.var <- c(66, 7, 10, 16, 19, 28, 31, 34, 37, 58, 61, 65)

train.index <- sample(c(1:dim(churn_input)[1]), dim(churn_input)[1]*0.6) 

train.df <- churn_input[train.index, selected.var]
head(train.df)
head(train.index)
valid.df <- churn_input[-train.index, selected.var]

# run naive bayes
delays.nb <- naiveBayes(churn~., data = train.df)
delays.nb


# predict probabilities
pred.prob <- predict(delays.nb, newdata = valid.df, type = "raw")
head(pred.prob)

# predict class membership
pred.class <- predict(delays.nb, newdata = valid.df)
head(pred.class)
head(valid.df)

df <- data.frame(actual = valid.df$churn, predicted = pred.class, pred.prob)



#confusion matrix
classification <- ifelse(pred.prob[,2]>0.65,1,0)
actual <- valid.df$churn

confusionMatrix(as.factor(classification), as.factor(actual))

predObj <- prediction(pred.prob[,2], valid.df$churn) 
rocObj = performance(predObj, measure="tpr", x.measure="fpr")
aucObj = performance(predObj, measure="auc")  
plot(rocObj, main = paste("Area under the curve:", round(aucObj@y.values[[1]] ,4)))

