#----Data Visualization----
##---Base graphics----
# -> plots are build steps by steps using function calls (traditional)
##---ggplot2----
# -> based on grammar of graphics, using a layered approach (modern)

#example of Base Plot
#Data
attach(DATA) # German Credit Risk Dataset

#----Base Graphics-----
# Step 1: Create empty plot
plot(Duration, Credit_amount, type="n",
     xlab="Loan Duration (months)", ylab="Credit Amount")

# Step 2: Add points
points(Duration, Credit_amount, pch=19, col="darkblue")

# Step 3: Add regression line
abline(lm(Credit_amount ~ Duration, data=NEWDATA), col="red")

# Step 4: Add title
title("Credit Amount vs Duration (Base R)")

# Step 5: Add legend
legend("topright", legend=c("Data", "Fit"),
       col=c("darkblue", "red"), pch=c(19, NA), lty=c(NA, 1))


#example of ggplot2 
# Load Package
library(ggplot2)

#----ggplot Graphics----
ggplot(DATA, aes(x=Duration, y=Credit_amount)) +
  # Layer 1: Points
  geom_point(aes(color=Housing), size=2, alpha=0.7) +
  
  # Layer 2: Smooth regression line
  geom_smooth(method="lm", se=FALSE, color="red") +
  
  # Layer 3: Add text labels for high credit amounts
  geom_text(aes(label=ifelse(Credit_amount > 15000, rownames(NEWDATA), "")),
            hjust=-0.2, vjust=0.5, size=3) +
  
  # Layer 4: Facet by Job type
  facet_wrap(~Job) +
  
  # Layer 5: Customize theme
  theme_minimal() +
  theme(legend.position="bottom") +
  
  # Layer 6: Titles and labels
  labs(title="Credit Amount vs Duration",
       subtitle="Colored by Housing, Faceted by Job",
       x="Duration (months)",
       y="Credit Amount",
       color="Housing")


