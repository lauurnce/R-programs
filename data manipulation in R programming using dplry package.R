#----Data Manipulation using dplry Package----
##----Pipe Chaining Operator (%>%)----
# -> allows chaining multiple operations together
# syntax: 
# data %>% filter(condition) %>% select(columns) %>% arrange(order)
# shortcut: ctrl + shift + M 

##----Common Functions----
###----filter()----
# -> extracts row that meet specific conditions
# syntax: 
# <DATA> %>% filter(<condition> & ... &<condition>)
# -> operator "&" used to denote multiple conditions 
#load package 
library(dplyr)

NEWDATA <- DATA %>% filter(Sex == "male" & Job >=2)
# "DATA" is from the attached file 

###----select()---- 
# -> chooses specific columns from a dataset. 
# syntax: 
# <DATA> %>% select (<var>, ...,<var>)

# --> to select series of columns
# <DATA> %>% select(<start_var>:<end_var>)
# --> to remove columns
# <DATA> %>% select(-<vector containing the variables to remove>)
NEWDATA <- NEWDATA %>% select(Age, Sex, Job, Housing, Credit_amount:Risk)

###----mutate()----
# -> creates or transform variables
# syntax: 
# <DATA> %>% mutate(<newcolumnname> = <formula>)
mtcars %>% mutate(kpml = mpg * 0.425)
####----conditional statement in R----
# syntax: 
# ifelse(<condition>, <true value returned>, <false returned>)
ifelse(Credit_amount <= 5000 & Duration <= 12, "Approve", "Not Approve")

###----summarize()----
# -> produces summary statistics for variables 
# syntax: <DATA> %>% summarize(<newcolumnname> = <function>(<variable>, na.rm = <T/F))
descriptive_stats <- NEWDATA %>% summarize(avg_credit_amount = mean(Credit_amount, na.rm = T), 
                                                SD_credit_amount = sd(Credit_amount, na.rm = T))

###----group by()----
# -> organizes data into groups based on one or more variables
# syntax: 
# data %>% group_by(column) %>% summarize (summary_stat = function(variable))
ds_male_groupedby_housing <- NEWDATA %>% group_by(Housing) %>% 
  summarize(avg_credit_amount = mean(Credit_amount, na.rm= T), 
            SD_credit_amount = sd(Credit_amount, na.rm = T))