
# Author: Krista Kraskura
# Last modified: March 2 2024 
# Topic: if else statements, loops, and functions

# A few good resources: 
# https://erdavenport.github.io/R-ecology-lesson/03-loops-and-functions.html
# 

# setup ----
# install libraries 
library(ggplot2)
library(tidyverse) 
library(here)

# import data from week 1
data<-read.csv("w1/dfexample.csv")
data<-data[order(data$snail.aggressiveness),]

# 1. if else  ------

# if (condition is TRUE) {
#   do something
# } else {
#   do different thing
# }

# conceptual demo:
a <- 1
a <- 5

if(a == 1){
  print("correct")
} else {
  print(paste("Not correct, a is", a))
}


# for loop that confirms that the first row in data for column snail aggressiveness is 1. 
if(data$snail.aggressiveness[1] == 1){
  
  print("Lowest aggressiveness is 1") # also can use message()
  agreessiveness <- 1 # asign values 

} else {
  
  print("Lowest agressiveness is NOT 1")
  agreessiveness <- data$snail.aggressiveness[1]

}

# 2. for loops -----

# for (variable in vector) {
#   do something
# }

# conceptual demo:
# the general format or syntax of the for loop 
for (i in 1:10) {
  # Command(s) to be repeated for all values i in x
  # e.g. the ith round of following instructions written inside the loop
  print(i)
  # message(paste("loop iteration", i))

}


# loop over the data and rescale agressiveness from 0 - 4 scale. 
# the concept step by step:

# data$snail.aggressiveness[1]<-data$snail.aggressiveness[1]-1 # first row 
# data$snail.aggressiveness[2]<-data$snail.aggressiveness[2]-1 # second row 
# ... all rows 

# the same in the loop
for (i in 1:nrow(data)){
  
  data$snail.aggressiveness[i]<-data$snail.aggressiveness[i]-1

}
  
# working with loops conditionally : if else statements
for (i in 1:nrow(data)){
  
  if (data$snail.aggressiveness[i] < 2){
    data$aggressiveness[i]<-"docile"
  } else {
    data$aggressiveness[i]<-"aggressive"
  }

}

# use STOP in a loop
for (i in 1:nrow(data)){
  
  if(data$snail.color[i]=="blue"){
    stop(paste("stop at", i, " blue snail")) # write error message
  }
}




# 3. functions -----

# function_name <- function(args) {
#   body
#   return(new_object)
# }

# conceptual demo: 
# `nsq` is function name
# `x` is an argument
# `	n <- x^2
# 	print(n)
# 	return(n)` is function body


nsq <- function(x){
  
	n <- x^2 
	return(n) # must return value if you want to use it "outside" of the function's environment 
	# once a value is returned, the function stops executing, 'it has done its job"
	# return(invisible(n)) # quiet return

}

# apply function
nsq(3)
nsq(10)


# functions can be executed on a vector:	
v<-c(3,2,1,4,5,6)	

# same result: 
c(3^2, 2^2, 1^2, 4^2, 5^2, 6^2) # manual works
new_n<-nsq(v) # function

# additional useful things to know about functions
# defaults
nsq<-function(x = 2)	{

  n<-x^2
  return(n)
  
}

nsq()

# return multiple objects
nsq<-function(x = 2)	{
  
  n<-x^2
  n2 <- n + 5.2396523697 # demo no return first 
  return(list(n, n2)) # to return multiple values must list

}

nsq(x =3)
nsq()
nsq()[[1]]


# working with our snail data example 
data.agr<-data[data$aggressiveness == "aggressive",]
data.doc<-data[data$aggressiveness == "docile",]

plot.snails<-function(plot.data, plot.title){
  
  p<-ggplot(plot.data, aes(x = snail.size, y = dist.from.transect))+
    geom_point(pch = 21, size = 3, fill = "grey")+
    theme_classic()+
    geom_smooth(method = "lm", color = "black")+
    ylab("Dist from transect (m)")+
    xlab("Snail size (g)")+
    theme(axis.text = element_text(size =15), 
          axis.title = element_text(size =15))+
    ggtitle(plot.title)
  
  return(p)
}
  
plot.snails(data.agr, "Agressive snails")
plot.snails(data.doc, "Docile snails")



