# WGUDataAnalyticsCapstone--Sprinkle
This project was planned to use the CDC's Behavioral Risk Factor Surveillance data, as cleaned and parsed by Kaggle user Alex Teboul, to test for Smoking, High Blood Pressure, and Sedentary Lifestyle as secondary risk factors for Type 2 Diabetes. To accomplish this, the following steps were taken:

1.	Extract data from the CDC via a Kaggle csv
2.	Change column names—DMStatus was changed from Diabetes_012 for human readability and PhyActivity was changed to Sed (Sedentary) for reasons explained in point 4.
3.	Transformation of response variable (DMStatus)—the response variable was categorized in three segments: non-diabetic, prediabetic, and diabetic. Because the researcher wanted to look at “healthy” versus “unhealthy,” this was transformed to a binomial using an ifelse statement.
4.	Transformation of predictor variable (Sed)—this predictor variable originally indicated a subject exercising as 1 and being sedentary as 0.  Because the other predictors were based on unhealthy factors or behaviors, this predictor was flipped using an ifelse statement.
5.	Conversion of columns from integers to factors—because the research was based on categorical information, these columns needed to be seen by R as factors rather than integers.
6.	Create subset to get needed data—for simplicity, the researcher made a new dataset, removing the BMI column, leaving only DMStatus (response), and Smoker, HighBP, and Sed (predictors).
7.	Create logistic regressions for single predictors—logistic regressions served the purpose best for this research, as all predictors and responses were categorical.
8.	Create new data frames for graphical representation—to graphically represent the findings, the researcher created predictive datasets.
9.	Sort graphical data frames—to fit the curves to the indexed respondents, the researcher order likelihood of diabetes from lowest probability to highest probability.
10.	Add ranks to the graphical data frames—ranks were added to stretch the respondents all along the X axis. 
11.	Plot data and save plots using ggplot2 and cowplot.

In the end, while some correlations were indicated, the McFadden Pseudo R2 calculations on each predictor were not in the range to indicate statistical signficiance.

The data can be found here:  https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset


