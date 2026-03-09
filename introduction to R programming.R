#----Introduction to R----
##----R Basics----
#Assigning Variables 
x <- 3.14 #numeric
y <- 42L #integer
flag <- TRUE #logical 
name <- "Alice" #character 

#to determine the type of a variable
class(x)
class(y)
class(flag)
class(name)

##----Defining Function in R----
square <- function(x){
  results <- x*x 
  return(results)
}

square(9)
