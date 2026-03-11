
# importing German Credit Risk Dataset
library(readxl)
German_Credit_Risk <- read_excel("C:/Users/Admin/Downloads/German Credit Risk.xlsx")
View(German_Credit_Risk)
DATA <- German_Credit_Risk

# ---- Defining a Custom Function ----
# PURPOSE:
# This function calculates the exact monthly payment required for an AI
# subscription (like Gemini Advanced). Since digital services often include
# a 12% Value Added Tax (VAT), this function automatically adds that tax
# to the base price before dividing it into monthly installments.

# INPUTS (Arguments):
# 1. base_subscription_amount: The total cost of the subscription BEFORE taxes (numeric).
# 2. duration_months: The number of months to split the payment into (numeric).

calc_gemini_monthly <- function(base_subscription_amount, duration_months) {
  
  # STEP 1: Calculate the total cost by applying a 12% VAT
  total_with_tax <- base_subscription_amount * 1.12 
  
  # STEP 2: Divide the total taxed amount by the number of months to get the monthly rate
  monthly_payment <- total_with_tax / duration_months
  
  # STEP 3: Output the final calculated monthly payment
  return(monthly_payment)
  
}

##---- Testing the Function ----
# Let's simulate an annual subscription that costs 13,200 before tax.
# We want to know how much we need to pay per month over a 12-month period.
calc_gemini_monthly(13200, 12)



# ---- Data Structures in R ----
## ---- Vector ----
# Example: Storing information about a project's core team members
# 1. Character Vector (Text/Strings)
# Stores the names of the team members. (Text must always be enclosed in quotes.)
v_team_member <- c("Eugene", "Lester", "Steven", "Chino")

# 2. Numeric Vector (Numbers)
# Stores the years of coding experience for each respective member. 
v_experience_years <- c(2, 2, 1, 5)

# 3. Character Vector (Categories/Text)
# Stores their designated roles for the tech event.
v_role <- c("Investor", "Developer", "Designer", "Manager")

## ---- Factor ----
###----1. Unordered Factor----
# Used when the categories do not have a natural ranking or hierarchy.
# Example: The 'Housing' column contains values like "own", "rent", and "free". 
# One housing status is not mathematically "greater" or "less" than another.

f_housing <- factor(DATA$Housing)

###----2. Ordered Factor (Custom Categories / Hierarchy)----
# Used when categories have a strict, logical progression. 
# Here, we use the numeric 'Job' column (which contains 0, 1, 2, 3). 
# We tell R the correct order using the 'levels' argument, and then we create 
# our custom categories using the 'labels' argument!

f_job_level <- factor(DATA$Job, 
                      levels = c(0, 1, 2, 3), 
                      labels = c("Entry-Level", "Junior", "Mid-Level", "Senior"),
                      ordered = TRUE)

# By defining the levels and labels this way, R now understands the logical progression:
# "Entry-Level" < "Junior" < "Mid-Level" < "Senior"

## ---- Table ----
###----1. One-Variable Table (Frequency Count)----
# Let's count the total number of "good" vs "bad" credit risks in the dataset.
t_risk_status <- table(DATA$Risk)
# What it does: Outputs a simple count (Good: 700, Bad: 300).

###----2. Two-Variable Table (Cross-Tabulation)----
# Let's see if there is a relationship between a person's Housing status 
# (rent, own, free) and their Credit Risk (good, bad). 
t_housing_vs_risk <- table(DATA$Housing, DATA$Risk)
# What it does: Creates a 2D matrix where rows are Housing status and columns are Risk. 
# This helps us see if homeowners default less than renters.

###----3. Three-Variable Table (Multi-Dimensional Array)----
# Let's take it a step further. We'll look at Housing, Risk, and whether the 
# loan is a "Short Term" loan. 
# We can actually put a condition (like Duration <= 12) directly inside the table!
t_housing_risk_shortterm <- table(DATA$Housing, DATA$Risk, DATA$Duration <= 12)
# What it does: This generates TWO separate 2D tables (Housing vs Risk). 
# One table will be for FALSE (loans longer than 12 months), and the other 
# will be for TRUE (loans 12 months or shorter).

## ---- Data Frame ----.
# Let's create a data frame for tracking a tech project team.

# STEP 1: Create the individual vectors (columns)
# Notice that each vector has exactly 4 elements.
v_member <- c("Lester", "Eugene", "Chino", "Steven")
v_tech_stack <- c("Python", "Flutter", "Figma", "AWS")
v_project_role <- c("AI/Backend", "Mobile Dev", "UI/UX", "Cloud Architect")
v_eval_score <- c(95, 88, 92, 90)

# STEP 2: Combine the vectors into a single Data Frame
# syntax: new_df <- data.frame(ColumnName = <vector>, ...)
df_tech_team <- data.frame(
  Team_Member = v_member,
  Primary_Skill = v_tech_stack,
  Role = v_project_role,
  Performance_Score = v_eval_score
)
# What it does: If you run 'df_tech_team', it will output a formatted 4x4 table 



# ---- Data Manipulation using dplyr Package ----
# Load the package
library(dplyr)

###---- 1. filter() and select()----
# Let's find young professionals (Age <= 25) who are asking for decent-sized
# loans (Credit_amount >= 2000), perhaps to fund new servers or cloud architecture.
# We then select only the columns relevant to our tech-loan analysis.

tech_candidates <- DATA %>% 
  filter(Age <= 25 & Credit_amount >= 2000) %>% 
  dplyr::select(Age, Job, Housing, Credit_amount, Duration, Risk)

###----2. mutate() and conditional statement ifelse()----
# Now, let's create TWO new columns. 
# First: Calculate their estimated monthly payment.
# Second: Automatically flag them for "Fast-Track" approval if R assesses 
# them as a "good" risk and they plan to pay it off in under 2 years (24 months).

tech_candidates <- tech_candidates %>% 
  mutate(
    Est_Monthly_Pay = Credit_amount / Duration,
    Approval_Status = ifelse(Risk == "good" & Duration <= 24, "Fast-Track", "Manual Review")
  )

###---- 3. group_by() and summarize()----
# Finally, let's generate some descriptive statistics for a report. 
# We will group these young tech candidates by their Job level and calculate 
# the average funding they are requesting, as well as count how many exist in each group.

tech_loan_summary <- tech_candidates %>% 
  group_by(Job) %>% 
  summarize(
    Avg_Requested_Funding = mean(Credit_amount, na.rm = TRUE),
    Max_Duration_Months = max(Duration, na.rm = TRUE),
    Total_Applicants = n() 
  )

# View the final summarized report
tech_loan_summary


# ---- Data Visualization ----

# Load required package
library(ggplot2)

attach(DATA) 

## ---- 1. Base Graphics (Traditional Step-by-Step Approach) ----

# Step 1: Create an empty plot canvas
# 'type="n"' tells R to set up the axes but NOT draw the points yet.
plot(Age, Credit_amount, type="n", 
     xlab="Applicant Age (Years)", 
     ylab="Requested Tech Funding (Credit Amount)",
     main="Empty Canvas Setup")

# Step 2: Add the data points
# We use pch=16 for solid circles, and color them based on Risk.
# We have to split the points to color "good" risk blue and "bad" risk red.
points(Age[Risk == "good"], Credit_amount[Risk == "good"], pch=16, col="steelblue")
points(Age[Risk == "bad"], Credit_amount[Risk == "bad"], pch=17, col="firebrick")

# Step 3: Add a regression line (Trend line)
# This shows the general mathematical trend between Age and Credit Amount.
abline(lm(Credit_amount ~ Age, data=DATA), col="darkgreen", lwd=2)

# Step 4: Add the main title
title(main="Tech Funding Requests by Age (Base R)")

# Step 5: Add a legend so the viewer knows what the colors mean
legend("topright", 
       legend=c("Good Risk", "Bad Risk", "Trend Line"),
       col=c("steelblue", "firebrick", "darkgreen"), 
       pch=c(16, 17, NA), 
       lty=c(NA, NA, 1))

##---- 2. ggplot2 Graphics (Modern Layered Approach) ----
ggplot(DATA, aes(x = Age, y = Credit_amount)) +
  
  # Layer 1: Scatter plot points
  # 'alpha = 0.6' makes points slightly transparent so overlapping data is visible.
  geom_point(aes(color = Risk), size = 2, alpha = 0.6) +
  
  # Layer 2: Smooth regression line
  # 'se=FALSE' removes the grey confidence interval shadow for a cleaner look.
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
  
  # Layer 3: Add text labels for massive outlier loans (e.g., above 15000)
  # This highlights massive funding requests without cluttering the whole chart.
  geom_text(aes(label = ifelse(Credit_amount > 15000, "High Value", "")), 
            vjust = -1, size = 3, color = "darkgray") +
  
  # Layer 4: Facet wrap (Split the chart)
  # We split the visual into two side-by-side charts based on 'Sex'.
  facet_wrap(~ Sex) +
  
  # Layer 5: Customize the visual theme
  theme_minimal() +
  theme(legend.position = "bottom", 
        plot.title = element_text(face="bold")) +
  
  # Layer 6: Professional Titles and Labels
  labs(title = "Tech Funding Distribution: Age vs. Credit Amount",
       subtitle = "Categorized by Risk Assessment and Split by Gender",
       x = "Applicant Age",
       y = "Requested Credit Amount",
       color = "Risk Level")

# Note: Always remember to detach the data when you are done to keep your environment clean!
detach(DATA)