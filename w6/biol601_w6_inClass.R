# type here...

# set up -----

library(ggplot2)
library(tidyverse)

data<-read.csv("./w1/dfexample.csv")

# if else -----

# if(condition is TRUE){
  # do something
# }else{
  # do something eles
#}


a <- 11

if(a == 10){
  
  print("correct")
  
}else{
  
  print(paste("a is NOT 1, it is", a))
  message("not correct")
}

data<-data[order(data$snail.aggressiveness),]

if(data$snail.aggressiveness[1]==1){
  aggressiveness <- "docile"
  print(aggressiveness)
}else{
  aggressiveness <- "aggressive"

}


# for loops -----

# for (variable in vector){
#   do something
# }

for(i in 1:10){
  
  print(i)

}

# manually doing work 
# data$snail.aggressiveness[1]<-data$snail.aggressiveness[1]-1
# data$snail.aggressiveness[2]<-data$snail.aggressiveness[2]-1

# for loop for the same result
for(i in 1:nrow(data)){
  data$snail.aggressiveness[i]<-data$snail.aggressiveness[i]-1
}

# for loop with if else
for(i in 1:nrow(data)){
  
  if(data$snail.aggressiveness[i] < 2){
    data$agg.cat[i]<-"docile"
  }else{
    data$agg.cat[i]<-"agg"
  }
  
}

# stopping loops 
for(i in 1:nrow(data)){
  if(data$snail.color[i] == "blue"){
    print(which(data$snail.color == "blue"))
    stop(paste("snail is blue in line", i))
  }
}

# functions ----

# function_name <- function(arguments){
  # body 
  # return()
#}

nsq<-function(x){
  n<-x^2
  a<-x^2+4.229769273602860
  return(list(n, a))
}

new_n<-nsq(3)[[1]]
new_a<-nsq(3)[[2]]

# writing or defining a function
plot.snails<-function(data.plot, plot.title){
  
  p<-ggplot(data = data.plot, aes(snail.size, dist.from.transect))+
    geom_point(pch=21, size=3, fill="grey")+
    geom_smooth(method = "lm")+
    ylab("Dist. from transect (m)")+
    xlab("Snail size (g)")+
    theme_classic()+
    theme(axis.text = element_text(size = 15),
          axis.title = element_text(size = 15))+
    ggtitle(plot.title)
  
  return(p)
  
}

plot.snails(data.plot = data,
            plot.title = "All snails")

# applying function to 2 data subsets
data.agg<-data[data$agg.cat == "agg",]
data.doc<-data[data$agg.cat == "docile",]

plot.snails(data.plot = data.agg, plot.title = "Aggressive snails")
plot.snails(data.plot = data.doc, plot.title = "Docile snails")
