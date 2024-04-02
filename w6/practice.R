
vec<-c("birds", "fish", "crustaceans", "plants", "bacteria", "mammals", "gastropods")

for(i in 1:length(vec)){
  print(vec[i])
  
  if(vec[i] == "bacteria"){
    message()
    next    
  }
    
}


for (i in 1:nrow(iris)){
  
  if(iris$Species[i] == "virginica" ){
    if(iris$Petal.Width[i] < 2){
      iris$class[i]<-"morph1"
    } else {
      iris$class[i]<-"morph2"
    }
  }
  
  
  if(iris$Species[i] == "versicolor" ){
    if(iris$Petal.Width[i] < 1.3){
      iris$class[i]<-"morph1"
    } else {
      iris$class[i]<-"morph2"
    }
  }
  
  
  if(iris$Species[i] == "setosa" ){
    if(iris$Petal.Width[i] < 0.3){
      iris$class[i]<-"morph1"
    } else {
      iris$class[i]<-"morph2"
    }
  }
  
}

