#----Data Structures in R----
## ----Vector----
#syntax: 
#c(<elements>, <elements>, <elements>)
v_name <- c("Kezia", "Paul", "Denmar", "Harold", "Craig")
v_age <- c(20, 20, 19, 20, 19)
v_gender <- c("F", "M", "M", "M", "M")

##----Factor----
#syntax:
#factor(<vector>, levels = c(<order of labels>), ordered = TRUE/FALSE)
f_gender <- factor(v_gender)

##----Table----
#like an Array
#syntax/example:
#t_job <- table(Job) #One Variable Table
#t_sex_job <- table(Sex, Job) #Two Variable Table 
#t_sex_job_savings <- table(Sex, Job, Saving_accounts) #Three Variable Table

##----Data Frame----
#2d data structure that consists of multiple vectors
#each vector must be same data type
#syntax: 
#md_df <- data.frame(column1 = <vector>, column2 = <vector>...)
df_vectors <- data.frame(Name = v_name, Age = v_age, Gender = v_gender)
