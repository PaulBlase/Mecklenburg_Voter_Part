# Mecklenburg County Voter Participation

When analyzing the outcome of an election, attention is generally paid to two main attributes of registered voters: who earned votes and
who came out to vote. Often, it is relatively easy to project the direction a vote would go, with past voting, income, education, etc.
being strong indicators of partisan lean. However, encouraging voting is a unique question, constantly changing with the utilization of
social media and the divisive strategies of politicians.

So what indicates a likely voter? What factors lead to a citizen being a participating in an election? More importantly, do we see 
certain indicators, and how might those indicate flaws in the voting process?

These questions in mind, the team began evaluating the data in order to answer these questions. Data used was acquired via https://mcmap.org/geoportal/,
which provided the boundaries used as well as the information used to assess the voter participation in Mecklenburg County.

## Preparing & Manipulating the Data

In reviewing literature prior to a study of the data, a few aspects were brought to the team's attention. We find lower participation within
certain groups, specifically younger and minority voters. Additionally, lower education and income indicated lower participation, as well as poor
transportation networks and high crime.

Prior to being able to evaluate these assessments, we needed to evaluate the data we had and ensure the information we had could be utilized to 
answer our questions.

![boxplot_outliers](https://user-images.githubusercontent.com/40553610/58067920-503f2000-7b5d-11e9-9088-67cd0998b928.jpeg)

With the initial dataset, the team selected 24 features to evaluate the question. However, the initial 462 variables featured some distinct outliers.
As much as the entire population was accounted for, ensuring drastic differences from the norm did not effect the data used was vital.
In removing outliers and assessing correlation of the variables we found valuable initially, several were found to be collinear and were removed.
Additionally, the dataset contained some missing values, which were accounted for by running mice.

![VIM_Plot](https://user-images.githubusercontent.com/40553610/58068146-29cdb480-7b5e-11e9-866f-a1b21156dd8e.jpeg)

In the end, 12 features were selected to assess the problem. These are listed below:

![data_info1](https://user-images.githubusercontent.com/40553610/58068190-5c77ad00-7b5e-11e9-9769-02b7f3816b23.jpg)

These would be used a variables to predict the final target, voter participation in the 2016 presidential election.

## Modeling the Data

In an attempt to categorize groups, the different regions were stratified based on quartiles for the target variable.

![class_breaks](https://user-images.githubusercontent.com/40553610/58068277-bbd5bd00-7b5e-11e9-8eba-11d5aafb00a5.jpeg)

With this in mind, the group decided to proceed utilizing a random forest, amongst other models, to assess the target variable.
This would provide a thorough evaluation of all features and offer use insight into what information would be most valuable
to understand when considering predictive models.

![ROC_RF](https://user-images.githubusercontent.com/40553610/58068453-69e16700-7b5f-11e9-9f10-3c792dc6ca23.png)

Based on the model, there was considerable success predicting the participation outcomes on the ends of the data, though the random
forest struggled to pinpoint differences in the margins. With arbitrary lines drawn between values and a non-normal distribution of 
target values, this is entirely resonable. 

![rf_map](https://user-images.githubusercontent.com/40553610/58069507-7667be80-7b63-11e9-8a65-4aeb0d609eeb.JPG)

![varImp](https://user-images.githubusercontent.com/40553610/58068556-c775b380-7b5f-11e9-9e89-573f8ac0c3da.jpeg)

In assessing the variables, what we see is that clearly race plays a factor, with registered white voters being a significant factor
in participation. Similarly, high income and home ownership are valuable along with public nutrition assistance.

![public_aid](https://user-images.githubusercontent.com/40553610/58068668-394dfd00-7b60-11e9-98a1-ac7b287742d6.png)
![ownership_viz](https://user-images.githubusercontent.com/40553610/58068680-436ffb80-7b60-11e9-99ef-8215a65da7a9.png)

One finding that was particularly interesting was the value of participation in past elections. While by far the best indicator, 
certain elections were more predictive than others. In evaluating national election turnout, participation in 2010 and 2014 was better
at predicting participation in 2016 than participation in 2012. What could be the cause of this?

Two theories could be made. The first would be that, with Obama running in 2012 as an incumbent, this drew a different crowd to the 
pools, with Republican voters in Mecklenburg not particularly enthusiastic about Mitt Romney. While this is entirely plausible, the second
theory seems to hold more true.

![voter_part_comp1](https://user-images.githubusercontent.com/40553610/58068793-d446d700-7b60-11e9-8acd-887ffeb96e15.png)

With so much coverage in the build up to each and every presidential election, individuals become invested in the process and, therefore are
more available to vote at that time. However, 2010 and 2014 both held Congressional elections, which receive considerably less coverage in the
media, or at least consistently providing the same spotlight. With less association with an individual, and more with a party, individuals are
less likely overall to participate. 

This bares out in the data, showing similarities in 2012 between all groups, while the Congressional elections show a broad array of outcomes.

## Further investigation

While the results we found were interesting insights into the questions we had, there wasn't anything that particularly groundbreaking from the
outcomes discovered. From continued research, the team has pinpointed new data sources to evaluate individual voters and a wider array of features.
Utilizing the Mecklenburg voter database and census tract data, provided by SimplyAnalytics, we hope to further the progress made thus far.

![party_affil_voter_reg](https://user-images.githubusercontent.com/40553610/58069347-e4f84c80-7b62-11e9-9963-1f5763f41b85.JPG)

With further investigation, the team hopes to utilize voter registration records to understand changes in registration over time
and how legislation in North Carolina may have effected that. Additionally, we hope to develop the ability to predict participation based on census data
to expand on the features of the initial model as well as predict the likelihood of individual voters to participate in a given election.


