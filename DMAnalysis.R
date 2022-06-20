#Sets the working directory
setwd("C:/Users/dsprinkle/OneDrive - One Diversified/Documents/School/Capstone/")

#loads libraries
library(ggplot2)
library(cowplot)
 
#1. Extract data from the CDC via a Kaggle csv into an R dataset
DMData<-read.csv("DMIndicators.csv")
 
#2. Change column names
colnames(DMData)[1]<-"DMStatus"
colnames(DMData)[5]<-"Sed"
 
#3. Transform data in Response variable DMStatus
DMData$DMStatus<-ifelse(DMData$DMStatus==0, 0, 1)

#4. Transform data in predictor variable Sed
DMData$Sed<-ifelse(DMData$Sed==0, 1, 0)
 
#5 Conversion of columns from integers to factors
DMData$Smoker<-as.factor(DMData$Smoker)
DMData$HighBP<-as.factor(DMData$HighBP)
DMData$DMStatus<-as.factor(DMData$DMStatus)
DMData$Sed<-as.factor(DMData$Sed)

#6 Create subset to get needed data 
DMCat<-subset(DMData, select=c(DMStatus, Smoker, HighBP, Sed))
 
#7 Create logistic regressions for single predictors
smokelogistic<-glm(DMStatus~Smoker, data=DMCat, family="binomial")
highbplogistic<-glm(DMStatus~HighBP, data=DMCat, family="binomial")
sedlogistic<-glm(DMStatus~Sed, data=DMCat, family="binomial")
 

#8 Create new data frames for graphical representation
predicted.smoker<-data.frame(probability.of.DM=smokelogistic$fitted.values,DM=DMCat$DMStatus)
predicted.highbp<-data.frame(probability.of.DM=highbplogistic$fitted.values,DM=DMCat$DMStatus)
predicted.sed<-data.frame(probability.of.DM=sedlogistic$fitted.values,DM=DMCat$DMStatus)

#9 Sort graphical data frames
predicted.smoker<-predicted.smoker[order(predicted.smoker$probability.of.DM, decreasing=FALSE),]
predicted.highbp<-predicted.highbp[order(predicted.highbp$probability.of.DM, decreasing=FALSE),]
predicted.sed<-predicted.sed[order(predicted.sed$probability.of.DM, decreasing=FALSE),]

#10 Add ranks to the graphical data frames
predicted.smoker$rank <-1:nrow(predicted.smoker)
predicted.highbp$rank <-1:nrow(predicted.highbp)
predicted.sed$rank <-1:nrow(predicted.sed)

#=============================================================

#10 and 11 plot data and save plots

ggplot(data=predicted.smoker, aes(x=rank, y=probability.of.DM)) +
geom_point(aes(color=DM), alpha=1, shape=4, stroke=2)  +
xlab("Index")  +
ylab("Diabetes Likelihood") +
stat_smooth(method="glm", se=FALSE, method.args = list(family=binomial)) +
ggtitle("SMOKERS")


ggsave("smoker.jpg", plot =last_plot(), device ="jpeg", path =NULL, scale =1, width =NA, height =NA,
  units =c("in", "cm", "mm", "px"),dpi =300,limitsize =TRUE, bg =NULL)

ggplot(data=predicted.highbp, aes(x=rank, y=probability.of.DM)) +
geom_point(aes(color=DM), alpha=1, shape=4, stroke=2)  +
xlab("Index")  +
ylab("Diabetes Likelihood") +
stat_smooth(method="glm", se=FALSE, method.args = list(family=binomial)) +
ggtitle("HIGH BP")


ggsave("highbp.jpg", plot =last_plot(), device ="jpeg", path =NULL, scale =1, width =NA, height =NA,
  units =c("in", "cm", "mm", "px"),dpi =300,limitsize =TRUE, bg =NULL)


ggplot(data=predicted.sed, aes(x=rank, y=probability.of.DM)) +
geom_point(aes(color=DM), alpha=1, shape=4, stroke=2)  +
xlab("Index")  +
ylab("Diabetes Likelihood") +
stat_smooth(method="glm", se=FALSE, method.args = list(family=binomial)) +
ggtitle("SEDENTARY LIFESTYLE")

ggsave("sed.jpg", plot =last_plot(), device ="jpeg", path =NULL, scale =1, width =NA, height =NA,
  units =c("in", "cm", "mm", "px"),dpi =300,limitsize =TRUE, bg =NULL)
