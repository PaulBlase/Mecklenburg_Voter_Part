#Visualization: Assessing Variables
data$pred <- predict(rf, data[, -c(1:2)], type = "response")
data$pred_correct <- as.factor(ifelse(data$Turnout == data$pred, 1, 0))
data$pred_correct <- factor(data$pred_correct, levels = rev(levels(data$pred_correct)))

#Base layer
p <- ggplot(data, aes(x = Turnout, fill = pred_correct)) +
  scale_fill_manual("Correctly Predicted", values = c("1" = "LightBLue", "0" = "Black"), 
                    lab = c("Yes", "No")) +
  theme_minimal() +
  xlab("Turnout")

#Feature Assessment
p + geom_jitter(aes(y = Public_Nutrition_Assistance_2016  ),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Public Nutrition Assistance (%)") +
  labs(title = "Feature Assessment", subtitle = "Public Nutrition Assistance", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = c(0.85, 0.85))

png(filename="public_aid.png", 800, 500)
p + geom_jitter(aes(y = Public_Nutrition_Assistance_2016  ),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Public Nutrition Assistance (%)") +
  labs(title = "Feature Assessment", subtitle = "Public Nutrition Assistance", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = c(0.85, 0.85))
dev.off()

p + geom_jitter(aes(y = Household_Income_2016),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Household Income ($)") +
  labs(title = "Feature Assessment", subtitle = "Household Income", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = c(0.15, 0.85))

png(filename="income_viz.png", 800, 500)
p + geom_jitter(aes(y = Household_Income_2016),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Household Income ($)") +
  labs(title = "Feature Assessment", subtitle = "Household Income", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = c(0.15, 0.85))
dev.off()

p + geom_jitter(aes(y = White_Population_2016),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("White Population (%)") +
  labs(title = "Feature Assessment", subtitle = "White Population", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = "none")

p + geom_jitter(aes(y = Home_Ownership_2016),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Home Ownership (%)") +
  labs(title = "Feature Assessment", subtitle = "Home Ownership", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.position = "none")

png(filename="ownership_viz.png", 800, 500)
p + geom_jitter(aes(y = Home_Ownership_2016),
                shape = 21, size = 3.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Home Ownership (%)") +
  labs(title = "Feature Assessment", subtitle = "Home Ownership", 
       caption = "(Low= <68%, LowMid= 68-75%, HiMid= 75-80%, Hi= >80%)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.position = "none")
dev.off()

#Voter Participation
vp2014 <- p + geom_jitter(aes(y = Voter_Participation_2014),
                          shape = 21, size = 4.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Voter Participation (%)") +
  labs(subtitle = "Voter Participation in 2014: \nR +5.7, R + 2.4") +
  ylim(18, 90) +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = "none")

vp2012 <- p + geom_jitter(aes(y = Voter_Participation_2012),
                          shape = 21, size = 4.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Voter Participation (%)") +
  labs(subtitle = "Voter Participation in 2012: \nD +3.9, D +0.7") +
  ylim(18, 90) +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = "none")

vp2010 <- p + geom_jitter(aes(y = Voter_Participation_2010),
                          shape = 21, size = 4.5, color = "black", width = .2, alpha = 0.8) +
  ylab("Voter Participation (%)") +
  labs(subtitle = "Voter Participation in 2010: \nR +9.4, R +6.8") +
  ylim(18, 90) +
  theme(plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 12, face = "bold"), 
        legend.background = element_rect(fill="white", 
                                         size=0.5, linetype="solid"), 
        legend.position = "none")

#Outcome, Prior Polling
grid.arrange(vp2014, vp2012, vp2010, ncol=3, 
             top = textGrob(expression("Feature Assessment"),
                            gp=gpar(fontsize=20, fontface="bold"),vjust=.3,hjust=3.75))

png(filename="voter_part_comp1.png", 1500, 900)
grid.arrange(vp2014, vp2012, vp2010, ncol=3, 
             top = textGrob(expression("Feature Assessment"),
                            gp=gpar(fontsize=29, fontface="bold"),vjust=.3,hjust=2.7))
dev.off()
