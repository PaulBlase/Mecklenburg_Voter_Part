library(ggplot2)
library(dplyr)
library(VIM)
library(readxl)
library(mice)
library(car)
library(ROCR)
library(rgdal)
library(tmap)

#Adding additional information
meck_data <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 2)
meck_data1 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 3)
meck_data2 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 4)
meck_data3 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 5)
meck_data4 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 6)
meck_data5 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 7)
meck_data6 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 8)
meck_data7 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 9)
meck_data8 <- read_excel("qol-data/QOL_Data_October_2018.xls", skip = 1, sheet = 10)

#Voter Participation melt
voter_part <- meck_data3[, c(1,10,12,14,16,18)]

#Correlation of Voting Participation
voter_part_comp <- voter_part[complete.cases(voter_part), ]
cor(voter_part_comp)

#Similar election participation (Outcomes and prior polling listed next to per RCP)
cor(voter_part_comp[, -c(1, 2)], voter_part_comp$Voter_Participation_2016) #D +2.1, D +3.3 
cor(voter_part_comp[, -c(1, 3)], voter_part_comp$Voter_Participation_2015) #Gallup Prez Ap: 49%
cor(voter_part_comp[, -c(1, 4)], voter_part_comp$Voter_Participation_2014) #R +5.7, R + 2.4
cor(voter_part_comp[, -c(1, 5)], voter_part_comp$Voter_Participation_2012) #D +3.9, D +0.7
cor(voter_part_comp[, -c(1, 6)], voter_part_comp$Voter_Participation_2010) #R +9.4, R +6.8

#CORRELATION TABLES
#SHEET 2
meck_data_cor <- merge(voter_part[, -3], meck_data, by = "NPA")
colSums(is.na(meck_data_cor))
meck_data_cor <- meck_data_cor[colSums(is.na(meck_data_cor)) < 10]

meck_data_cor <- meck_data_cor[complete.cases(meck_data_cor), -1]
a <- cor(meck_data_cor[, -c(1:4)], meck_data_cor$Voter_Participation_2016)
b <- cor(meck_data_cor[, -c(1:4)], meck_data_cor$Voter_Participation_2014)
c <- cor(meck_data_cor[, -c(1:4)], meck_data_cor$Voter_Participation_2012)
d <- cor(meck_data_cor[, -c(1:4)], meck_data_cor$Voter_Participation_2010)
cor(meck_data_cor[, -c(1)], meck_data_cor$Voter_Participation_2016)

#SHEET 3
meck_data1_cor <- merge(voter_part[, -3], meck_data1, by = "NPA")
colSums(is.na(meck_data1_cor))
meck_data1_cor <- meck_data1_cor[colSums(is.na(meck_data1_cor)) < 10]

meck_data1_cor <- meck_data1_cor[complete.cases(meck_data1_cor), -1]
a <- rbind(a, cor(meck_data1_cor[, -c(1:4)], meck_data1_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data1_cor[, -c(1:4)], meck_data1_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data1_cor[, -c(1:4)], meck_data1_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data1_cor[, -c(1:4)], meck_data1_cor$Voter_Participation_2011))
cor(meck_data1_cor[, -c(1)], meck_data1_cor$Voter_Participation_2016)

#SHEET 4
meck_data2_cor <- merge(voter_part[, -3], meck_data2, by = "NPA")
colSums(is.na(meck_data2_cor))
meck_data2_cor <- meck_data2_cor[colSums(is.na(meck_data2_cor)) < 10]

meck_data2_cor <- meck_data2_cor[complete.cases(meck_data2_cor), -1]
a <- rbind(a, cor(meck_data2_cor[, -c(1:4)], meck_data2_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data2_cor[, -c(1:4)], meck_data2_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data2_cor[, -c(1:4)], meck_data2_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data2_cor[, -c(1:4)], meck_data2_cor$Voter_Participation_2011))
cor(meck_data2_cor[, -c(1)], meck_data2_cor$Voter_Participation_2016)

#SHEET 5
meck_data3_cor <- merge(voter_part[, -3], meck_data3, by = "NPA")
colSums(is.na(meck_data3_cor))
meck_data3_cor <- meck_data3_cor[colSums(is.na(meck_data3_cor)) < 10]

meck_data3_cor <- meck_data3_cor[complete.cases(meck_data3_cor), -1]
a <- rbind(a, cor(meck_data3_cor[, -c(1:4)], meck_data3_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data3_cor[, -c(1:4)], meck_data3_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data3_cor[, -c(1:4)], meck_data3_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data3_cor[, -c(1:4)], meck_data3_cor$Voter_Participation_2011))

#SHEET 6
meck_data4_cor <- merge(voter_part[, -3], meck_data4, by = "NPA")
colSums(is.na(meck_data4_cor))
meck_data4_cor <- meck_data4_cor[colSums(is.na(meck_data4_cor)) < 10]

meck_data4_cor <- meck_data4_cor[complete.cases(meck_data4_cor), -c(1, 20)]
a <- rbind(a, cor(meck_data4_cor[, -c(1:4)], meck_data4_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data4_cor[, -c(1:4)], meck_data4_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data4_cor[, -c(1:4)], meck_data4_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data4_cor[, -c(1:4)], meck_data4_cor$Voter_Participation_2011))
cor(meck_data4_cor[, -c(1)], meck_data4_cor$Voter_Participation_2016)

#SHEET 7
meck_data5_cor <- merge(voter_part[, -3], meck_data5, by = "NPA")
#colSums(is.na(meck_data5_cor))
#meck_data5_cor <- meck_data5_cor[colSums(is.na(meck_data5_cor)) < 15]

meck_data5_cor <- meck_data5_cor[complete.cases(meck_data5_cor), -1]
a <- rbind(a, cor(meck_data5_cor[, -c(1:4)], meck_data5_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data5_cor[, -c(1:4)], meck_data5_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data5_cor[, -c(1:4)], meck_data5_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data5_cor[, -c(1:4)], meck_data5_cor$Voter_Participation_2011))
cor(meck_data5_cor[, -c(1)], meck_data5_cor$Voter_Participation_2016)

#SHEET 8
meck_data6_cor <- merge(voter_part[, -3], meck_data6, by = "NPA")
colSums(is.na(meck_data6_cor))
meck_data6_cor <- meck_data6_cor[colSums(is.na(meck_data6_cor)) < 30]

meck_data6_cor <- meck_data6_cor[complete.cases(meck_data6_cor), -1]
a <- rbind(a, cor(meck_data6_cor[, -c(1:4)], meck_data6_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data6_cor[, -c(1:4)], meck_data6_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data6_cor[, -c(1:4)], meck_data6_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data6_cor[, -c(1:4)], meck_data6_cor$Voter_Participation_2011))

#SHEET 9
meck_data7_cor <- merge(voter_part[, -3], meck_data7, by = "NPA")
colSums(is.na(meck_data7_cor))
meck_data7_cor <- meck_data7_cor[colSums(is.na(meck_data7_cor)) < 50]

meck_data7_cor <- meck_data7_cor[complete.cases(meck_data7_cor), -1]
a <- rbind(a, cor(meck_data7_cor[, -c(1:4)], meck_data7_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data7_cor[, -c(1:4)], meck_data7_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data7_cor[, -c(1:4)], meck_data7_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data7_cor[, -c(1:4)], meck_data7_cor$Voter_Participation_2011))

#SHEET 10
meck_data8_cor <- merge(voter_part[, -3], meck_data8, by = "NPA")
colSums(is.na(meck_data8_cor))
meck_data8_cor <- meck_data8_cor[colSums(is.na(meck_data8_cor)) < 50]

meck_data8_cor <- meck_data8_cor[complete.cases(meck_data8_cor), -1]
a <- rbind(a, cor(meck_data8_cor[, -c(1:4)], meck_data8_cor$Voter_Participation_2016))
b <- rbind(a, cor(meck_data8_cor[, -c(1:4)], meck_data8_cor$Voter_Participation_2014))
c <- rbind(a, cor(meck_data8_cor[, -c(1:4)], meck_data8_cor$Voter_Participation_2012))
d <- rbind(a, cor(meck_data8_cor[, -c(1:4)], meck_data8_cor$Voter_Participation_2011))

rm(meck_data_cor, meck_data1_cor, meck_data2_cor, meck_data3_cor, meck_data4_cor, meck_data5_cor,
   meck_data6_cor, meck_data7_cor, meck_data8_cor)

#Evaluating Correlation Values
#2016 Election
a <- data.frame(cbind(rownames(a), a), stringsAsFactors = FALSE)
colnames(a) <- c("Feature", "Cor")
a$Cor <- as.numeric(a$Cor)
a <- a[order(a$Cor), ]

head(a, 10)
tail(a, 10)

a_2016 <- a[grepl("^.+(2016)$", a$Feature),]
head(a_2016, 10)
tail(a_2016, 10)

#2014 Election
b <- data.frame(cbind(rownames(b), b), stringsAsFactors = FALSE)
colnames(b) <- c("Feature", "Cor")
b$Cor <- as.numeric(b$Cor)
b <- b[order(b$Cor), ]

head(b, 10)
tail(b, 10)

#2012 Election
c <- data.frame(cbind(rownames(c), c), stringsAsFactors = FALSE)
colnames(c) <- c("Feature", "Cor")
c$Cor <- as.numeric(c$Cor)
c <- c[order(c$Cor), ]

head(c, 10)
tail(c, 10)

#2010 Election
d <- data.frame(cbind(rownames(d), d), stringsAsFactors = FALSE)
colnames(d) <- c("Feature", "Cor")
d$Cor <- as.numeric(d$Cor)
d <- d[order(d$Cor), ]

head(d, 10)
tail(d, 10)

#CREATING DATAFRAME FOR TESTING
data <- cbind(voter_part[,-3], meck_data[, c(6, 16, 20, 22, 26)], meck_data1[, c(2, 4, 8)], 
              meck_data2[, c(2, 4, 6, 26, 39)], meck_data5[, c(34, 41, 48)], 
              meck_data6[, 114], meck_data7[, 4], 
              meck_data8[, c(2, 19)])

rm(meck_data, meck_data1, meck_data2, meck_data3, meck_data4, meck_data5,
   meck_data6, meck_data7, meck_data8, voter_part)

#ASSESSING NA's and OUTLIERS
#Missing values
colSums(is.na(data))
aggr_plot <- aggr(data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

#Missing observations
data$NPA[is.na(data$Early_Care_Proximity_2017)]
data$NPA[is.na(data$Long_Commute_2016)]
data$NPA[is.na(data$Home_Ownership_2016)]
data$NPA[is.na(data$Household_Income_2016)]

#Number of NA's by row
sum(is.na(data[data$NPA == 62,]))
sum(is.na(data[data$NPA == 122,]))
sum(is.na(data[data$NPA == 243,]))
sum(is.na(data[data$NPA == 285,]))
sum(is.na(data[data$NPA == 456,]))
sum(is.na(data[data$NPA == 468,]))

#Removing incomplete observations
data <- data[rowSums(is.na(data)) < 5, ]
aggr_plot <- aggr(data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))
colSums(is.na(data))
sum(is.na(data))

#Correlation Heat Map (complete cases)
cor(data[complete.cases(data), -1])

#IMPUTING MISSING VALUES
#Margin plot for Violent Crime Rate
data_cor <- data[complete.cases(data), ]
cor(data_cor[, -c(1, 23)], data_cor$Violent_Crime_Rate_2016)
cor(data_cor[, -c(1, 21)], data_cor$`Public_Health_Insurance _2017`)

#Violent crime vs Public Health Insurance
marginplot(data[c(21,23)])

#Violent crime vs Public Nutrition Assistance
marginplot(data[c(12,23)])

#Public Health Insurance vs Public Nutrition Assistance
marginplot(data[c(12,21)])
#Public Nutrition and Public Health are at R^2 = .97

#Variables we intend to keep
colnames(data)
colnames(data[, -c(1, 6, 8, 10, 15, 16, 18, 19, 21, 23, 24, 25)])
sum(is.na(data[, -c(1, 6, 8, 10, 15, 16, 18, 19, 21, 23, 24, 25)]))

x <- list("Household_Income_2016", "Public_Nutrition_Assistance_2016", "Proficiency_Elementary_School_2016",
          "Births_to_Adolescents_2016", "Prenatal_Care_2016", "Public_Health_Insurance _2017")

#Imputed value table
na_table <- data[,colnames(data) %in% x]
na_table <- data.frame(ifelse(is.na(na_table), 1, 0))
na_table <- cbind(data$NPA, na_table)

#Impute values
data_imp <- data[, -c(1, 6, 8, 10, 15, 16, 18, 19, 21, 23, 24, 25)]
tempData <- mice(data_imp, m=5, maxit=50, meth='pmm', seed=500)
summary(tempData)

data_imp <- complete(tempData, 1)
data_imp <- cbind(data$NPA, data_imp)
colnames(data_imp)[1] <- "NPA"

#Final VIM plot
aggr_plot <- aggr(data_imp, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

#OUTLIERS
#Ploting features
boxplot(data_imp$Household_Income_2016)

#Non-income variables
ggplot(stack(data_imp[, -c(1, 8)]), aes(x = ind, y = values)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggtitle("Outliers from QoL Dataset") +
  xlab("Variables")

remove_outlier = function(df, column) {
  #find oyputs from the boxplot's stats output
  Q1 <- summary(df[,column])[2]
  Q3 <- summary(df[,column])[5]
  IQR <- (Q3 - Q1)
  lowerlimit <- (Q1 - 1.5*(IQR))
  upperlimit <- (Q3 + 3*(IQR))
  cat('Column:', column, '\n') 
  cat('Q1:', Q1, '\n') 
  cat('Q3:', Q3, '\n')
  cat('IQR:', IQR, '\n') 
  cat('lowerlimit:', lowerlimit, '\n') 
  cat('upperlimit:', upperlimit, '\n')
  #remove the outliers
  rec1 <- dim(df)[1]
  df <- df[df[,column]>lowerlimit & df[,column]<upperlimit,]
  rec2 <- dim(df)[1] 
  cat('Number of outliers removed from ', column, ' :', (rec1-rec2), '\n')
  df
}

outliers_table <- 
  remove_ouliers_from_all_columns <- function(testdata) {
    for (col in colnames(testdata)){
      if (col == "NPA"){
        next
      }
      testdata <- remove_outlier(testdata, col)
    }
    testdata
  }

str(data_imp)
testdata <- remove_ouliers_from_all_columns(data_imp)
dim(testdata)
colnames(testdata)

#Saving dataframes
write.csv(data_imp, "full_test_set.csv", row.names = FALSE)

ggplot(stack(testdata[, -c(1, 8)]), aes(x = ind, y = values)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggtitle("Outliers from QoL Dataset") +
  xlab("Variables")

write.csv(testdata, "cleaned_test_set.csv", row.names = FALSE)

#Create Table for Variables in Test Data
library(gridExtra)

data_info <- matrix(ncol = 7, nrow = ncol(testdata) - 1)

dim(testdata)

for(i in 1:(ncol(testdata) - 1)){
  data_info[i, 1] <- colnames(testdata[i + 1])
  data_info[i, 2] <- quantile(testdata[, i + 1])[[1]]
  data_info[i, 3] <- quantile(testdata[, i + 1])[[2]]
  data_info[i, 4] <- quantile(testdata[, i + 1])[[3]]
  data_info[i, 5] <- round(mean(testdata[, i + 1]), 3)
  data_info[i, 6] <- quantile(testdata[, i + 1])[[4]]
  data_info[i, 7] <- quantile(testdata[, i + 1])[[5]]
}

colnames(data_info) <- c("Variable", "Min", "1st Q.", "Median", "Mean", "3rd Q.", "Max" )  
grid.table(data_info)

png(filename="data_info.png", 800, 500)
grid.table(data_info)
dev.off()

sum(na_table[na_table$`data$NPA` %in% testdata$NPA, 2:7])
