library(ggplot2)
library(dplyr)
library(ROCR)
library(pROC)
library(rgdal)
library(tmap)
library(randomForest)
library(caret)
library(grid)
library(gridExtra)
set.seed(42)

data <- read.csv("cleaned_test_set.csv")

#Visualizing spread of target
ggplot(data, aes(Voter_Participation_2016)) +
  geom_density(fill = "lightblue", alpha = 0.6) +
  geom_vline(xintercept = 75, linetype = "dashed", color = "red", size = 1) +
  ggtitle("Initial Group Break")

#Creating new splits
summary(data$Voter_Participation_2016)
mean(data$Voter_Participation_2016)

p <- ggplot(data, aes(Voter_Participation_2016)) +
  geom_density(fill = "lightblue", alpha = 0.8) +
  geom_vline(xintercept = 68, linetype = "dashed", color = "red", size = 1) +
  geom_vline(xintercept = 75, linetype = "dashed", color = "red", size = 1) +
  geom_vline(xintercept = 80, linetype = "dashed", color = "red", size = 1) +
  ggtitle("Class Breaks") +
  annotate("text", x = 60, y = .02, label = "Low (<68%)") +
  annotate("text", x = 71.25, y = .045, label = "LowMid\n(68-75%)") +
  annotate("text", x = 78, y = .047, label = "HiMid\n75-80%)") +
  annotate("text", x = 85, y = .045, label = "Hi (>80%)") +
  theme_minimal()

jpeg("class_breaks.jpeg", 600, 375)
p
dev.off()

#New voter categories
data$Turnout <- cut(data$Voter_Participation_2016, breaks = c(-Inf, 68, 75, 80, Inf), 
              labels = c("Low", "LowMid", "HiMid", "Hi"))

table(data$Turnout)

#Visualizing past participation
ggplot(data, aes(x = Voter_Participation_2012, y = Voter_Participation_2014, col = Turnout)) +
  geom_point()

#Min/Max of prior turnout by group
data %>% 
  group_by(Turnout) %>% 
  summarise(min_val = ifelse(n() > 1, min(Voter_Participation_2014), 0), 
            max_val = ifelse(n() > 1, max(Voter_Participation_2014), 0))

data %>% 
  group_by(Turnout) %>% 
  summarise(min_val = ifelse(n() > 1, min(Voter_Participation_2012), 0), 
            max_val = ifelse(n() > 1, max(Voter_Participation_2012), 0))

data %>% 
  group_by(Turnout) %>% 
  summarise(min_val = ifelse(n() > 1, min(Voter_Participation_2010), 0), 
            max_val = ifelse(n() > 1, max(Voter_Participation_2010), 0))

#Mapping out groupings
meck_county <- readOGR(dsn = "qol-data", layer = "NPA_2014_meck")
shp <- merge(meck_county, data, by = "NPA")

tm_shape(shp) +
  tm_borders() +
  tm_fill("Turnout")

#Running Random Forest
#Train/test
smp_size <- floor(0.7 * nrow(data))

train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train <- data[train_ind, ]
test <- data[-train_ind, ]

#Mtry
mtry <- tuneRF(train[, -c(1, 2, 15)], train$Turnout, ntreeTry=100, 
               stepFactor=1.5, improve=0.01, trace=TRUE, plot=TRUE)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]

print(mtry)
print(best.m)

#Running Model
rf <-randomForest(Turnout~., data=train[, -c(1, 2)], mtry=best.m, importance=TRUE, ntree=100)
print(rf)

#Variable Importance
importance(rf)
varImpPlot(rf)

jpeg("varImpv1.jpeg", 800, 500)
varImpPlot(rf)
dev.off()

#Predicing test values
#Probability matrix for train
pred1 = predict(rf,type = "prob")

#Probability matrix for test
predicted_values = predict(rf, type = "response", test)
final_data <- cbind(test, predicted_values)

#Confusion Matrix
confusionMatrix(final_data$predicted_values, final_data$Turnout)
confusionMatrix(final_data$predicted_values, final_data$Turnout)$table %>%
  plotCM()

#MAPPING OUTCOMES
pred_map <- data.frame(cbind(data$NPA, predict(rf, type = "response", data)))
colnames(pred_map) <- c("NPA", "Class")
pred_map$Class <-as.factor(pred_map$Class)
levels(pred_map$Class) <- c("Low", "LowMid", "HiMid", "Hi")

shp <- merge(meck_county, pred_map, by = "NPA")
tm_shape(shp) +
  tm_fill("Class") +
  tm_borders()

# List of predictions
preds_list <- list(pred1[,1], pred1[,2], pred1[,3], pred1[,4])

# List of actual values (same for all)
m <- length(preds_list)
actuals_list <- list(train$Turnout == "Low", train$Turnout == "LowMid",
                     train$Turnout == "HiMid", train$Turnout == "Hi")

#ROC and AUC value
roc_obj <- roc(train$Turnout == "Hi", pred1[,4])
auc(roc_obj)

# Plot the ROC curves
pred <- prediction(preds_list, actuals_list)
rocs <- performance(pred, "tpr", "fpr")
plot(rocs, col = as.list(1:m), main = "Class ROC Curves")
legend(x = "bottomright", 
       legend = c("Low (AUC = .9453)", "LowMid (AUC = .844)", 
                  "HiMid (AUC = 8542)", "Hi (AUC = .9604)"),
       fill = 1:m)

png(filename="ROC_RF.png", 800, 500)
plot(rocs, col = as.list(1:m), main = "Class ROC Curves")
legend(x = "bottomright", 
       legend = c("Low (AUC = .9453)", "LowMid (AUC = .844)", 
                  "HiMid (AUC = 8542)", "Hi (AUC = .9604)"),
       fill = 1:m)
dev.off()

