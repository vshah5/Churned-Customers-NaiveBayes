# Churned-Customers-NaiveBayes
Using the data provided for the past 3 months, I have created a model by classifying the first two months as a customer’s happy phase and the 3rd month as a customer entering the sore phase. Based on this, I created a model which predicts which customers will enter the churn phase next month. By using this model, we will be able to identify and prevent customers from churning. Additionally, we can determine what the appropriate discount given to unsatisfied customers should be to retain them for a longer period of time and maximize our profits. 

In simple terms, the methodology to build this model utilized two statistical methods, logistic regression as well as Naïve Bayes. Both methods were used in order to determine which one of them gave a more powerful and accurate predictive model. Many different variables were inputted into the model such as roaming minutes, network minutes, amount of data used, and how long the customer had been with us, among others. Next, I was able to discern which variables had the highest predictive capacity for customers churning. After running both logistic regression and naïve bayes techniques, I found logistic regression to produce a model which produced 93% accuracy in predicting the churn of customers. Combining this model with historical information on how discount percentages led to a certain percentage of churning customers retained enabled me to produce a table which identified what discount percentage we should offer to our sore phase customers in order to retain them.

![image](https://user-images.githubusercontent.com/71670899/116789952-cf466e00-aa7f-11eb-8555-9e4dc7e97319.png)

![image](https://user-images.githubusercontent.com/71670899/116789949-c81f6000-aa7f-11eb-8c1a-951f6ff7c979.png)

![image](https://user-images.githubusercontent.com/71670899/116789955-d4a3b880-aa7f-11eb-9fc3-4c54a54157a0.png)
