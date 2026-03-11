
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
###---- 1. Unordered Factor----
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
###---- 1. One-Variable Table (Frequency Count)----
# Let's count the total number of "good" vs "bad" credit risks in the dataset.
t_risk_status <- table(DATA$Risk)
# What it does: Outputs a simple count (Good: 700, Bad: 300).

###----2. Two-Variable Table (Cross-Tabulation)----
# Let's see if there is a relationship between a person's Housing status 
# (rent, own, free) and their Credit Risk (good, bad). 
t_housing_vs_risk <- table(DATA$Housing, DATA$Risk)
# What it does: Creates a 2D matrix where rows are Housing status and columns are Risk. 
# This helps us see if homeowners default less than renters.

###---- 3. Three-Variable Table (Multi-Dimensional Array)----
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

