# Spring 2024 
# W. Ryan wryan@towson.edu
# BIOL 601: Dealing with your Data
# Introduction to basic functions in R
# Part 1: sec 1, Part 2: sec 2 - 4, Sneak peak of plotting: Part 5

# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#  (1) Core R functions:
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

# Use the hash tag (#) at the start of a line to add annotation (notes) that do not get read as code. Write notes about everything that is happening in your code so that you (or others) can figure it out later.

	# Do math (add two SCALARS [single numbers]):
		5 + 8
		
	# Assign an OBJECT:
		x = 5 # (or x <- 5)
		x	# call the object name to see what the value is
		
	# Re-assign the object with a new number:
		x = 4
		x # call the object to see what the new value is	
	
	# Do math using an assigned object (multiply the object by a SCALAR):
		x*3
		
	# Create a VECTOR of numbers:
		y = c(1,2,4,8)
		y # call the object to see what the vector looks like
		
	# Retrieve a specific ELEMENT of the VECTOR using its INDEX:
		y[3] # returns the 3rd element in the vector
	
	# Add a SCALAR (single number) to each element of a vector:
		4 + y	
		x + y # can also be done by adding two variables together
		
	# Make a new object that is a FUNCTION of two other variables
		new = x + y
		new		# call object and compare with result above	

# &&&&&&&&&&&&&&&&&&&&&&& Making vectors of a sequence of numbers: &&&&&&&&&&&&&&&&&&&&	
		
	# Make a vector that is a sequence of numbers:
		sequence1 = seq(from = 1, to = 20, by = 3) # sequence with set interval
		sequence1
		 
		sequence2 = seq(1,20, length.out = 30) # sequence with a set number of elements, spread equally across the interval
		sequence2
		
# &&&&&&&&&&&&&&&&&&&&&&& Dealing with matricies and arrays &&&&&&&&&&&&&&&&&&&&		
		
	# Make a matrix out of a vector (add 2-dimensional structure!):
		
		matrix1 = matrix(data = sequence2, nrow = 5)
	  matrix1	
	  
	  # select a single element of a MATRIX using INDICIES:
	  
	  matrix1[3,2] # [row,column] - pick the element at the 3rd row, 2nd column 
	  
	  # make a new object to store the result of multiplying all of the elements in your matrix by 2:
	  
	  matrix1.x2 = matrix1 * 2
	  matrix1.x2
	  
	# Make an ARRAY out of a vector (add N-dimensional structure!) : 
	  
	  array1 = array(data = sequence2, dim = c(5,3,2))
	  array1
		
	  # select a single element of an ARRAY using INDICIES:
	  
	   array1[1,3,2] # [row, column, set] - pick the element at the 1st row, 3rd column, 2nd set
	   
# &&&&&&&&&&&&&&&&&&&&&&& Making vectors of random numbers: &&&&&&&&&&&&&&&&&&&&		   
	
	
	 # Make a vector of numbers drawn randomly from a normal distribution:
		rando = rnorm(30, mean = 0, sd = 1)
		rando	# call the name of the vector to see what the values are
		
	# Select a particular ELEMENT out of a vector
		rando[5] # selects the 5th element of the vector
		
	# Try out some other randomization functions with different distributions
		runif(10, min = 10, max = 20) # uniform distribution between two end points - make a random number generator!
		rbinom(n = 10, size = 1 , prob = 0.5) # binomial distribution - make a coin flip generator!
		rpois(n = 10, lambda = 2) # poisson distributon - integers bounded by zero - make a random number of occurrences generator!
		sample(c("outlook not so good", "ask again later", "it is certain", "signs point to yes"), size = 1) # sample a vector of posibilities - make a magic 8 ball simulator!
	
# &&&&&&&&&&&&&&&&&&&&&&& Making and dealing with data frames: &&&&&&&&&&&&&&&&&&&&			
	
	# Make a data frame out of two vectors:
	
		df = data.frame(var1 = sequence2, var2 = rando) # imagine we are randomizing positions for small quadrats along a 20 meter transect
		df
		
	# select a particular element out of a data frame:
	
		df[1,2] # [row #, column #]
		
		df[1, ] # choose all elements of a row
		
		df[ , 2] # choose all elements of a column
		
		df$var2 # choose a variable (column) by name
		
		df[1,]$var2 # choose an element from a particular row for a column by name
	
		df$var2[1] # choose an element from a particular column by rownumber
		
		length(df$var2) # calculate how many elements are in a particular vector (or column)
		
	# add a column to a dataframe
	
		df$catvar = sample(c("A","B","C"), length(df$var1), replace = TRUE) # use "sample" function to randomly sample elements of a vector (with replacement) to populate a new column in your data frame. "length" function returns the length (number of elements) of a vector.
		df
		
		# Make a new variable that is a function of an old variable:
		
		df$var3 = df$var1*1.1+rnorm(length(df$var1), mean = 10, sd = 2) # using a linear function (y = mx) with some random noise
		
		
	  # look at the first few rows of your dataset
		head(df)
		tail(df)
		
		# check what the levels of a particular variable/factor are:
		unique(df$catvar) # "unique" function returns a vector with one copy of each unique level of a factor (categorical)
		
		# Rename these awful, uninformative variable names
		  colnames(df) = c("transect.position", "dist.from.transect", "substrate.type", "snail.size") # replace vector of column names with new vector of names
		  head(df) # check to make sure it worked
		
		  
		  # just for satisfaction purposes, let's look at a graph:
    library(ggplot2)
    ggplot(data = df, aes(x = transect.position)) + geom_histogram(aes(fill = substrate.type), binwidth = 3)
    ggplot(data = df, aes(x = transect.position, y = snail.size)) + geom_point(aes(color = substrate.type), size = 3)
    ggplot(data = df, aes(x = transect.position, y = snail.size)) + geom_point(aes(color = substrate.type), size = 3) + stat_smooth(method = glm, aes(color = substrate.type))
		
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		#  (2) Reading & writing data from a file:
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&		
		
		getwd() # check your current "working directory"
		setwd("/Users/will/Documents/BIOL 601 - working directory") # set a particular folder as your "working directory"
		
		# Writing CSV files:
		write.csv(df) # make a "comma separated" version of your dataframe in the console
		
		write.csv(df, file = "dataframeexample.csv") # save a .csv version of your data frame to the working directory
		
		# Reading CSV files:
		new.df = read.csv("dfexample.csv") # read in data from .csv file in working directory ( i added some other columns for example purposes)
		head(new.df)
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		#  (3) adding libraries:
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&	
		# download a package that is available through CRAN (only needs to be done once on your computer)
		#install.library(doBy) 
		#install.library(reshape2) 
		
		# activate a package that is already downloaded:
		library(doBy) 
		library(reshape2)
		#library(dplyr) # part of the "tidyverse"
		
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		#  (4) Subsetting & reorganizing data (tidyverse & non-tidyverse options)
		# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&	
		# Non-tidyverse options:
		
# &&&&&&&&&&&&&&&&&&&&&&&& Subsetting data frames: &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&		
		# Use SUBSET to make a version of the new.df dataframe by the following criteria:
		  
		  subset(new.df, substrate.type == "C") # only has data measured on substrate "C"
		  subset(new.df, transect.position > 10) # only has data from transect.positions greater than 10
		  subset(new.df, substrate.type == "C" & transect.position > 10) # meets both conditions above
		  
		  subset(new.df, substrate.type != "B") # != means "does not equal
		  
		  subset(new.df, substrate.type %in% c("A", "B")) # use "%in%" to set a list of values to include
		  
		  # Note: %in% operator can be useful other ways:
		    # check if any of a string of numbers is included in particular vector:
		      bob = c(3,4,5)
		        6 %in% bob # False
		        4 %in% bob # true
		        c(4,6) %in% bob
  		
		# Use WHICH to subset by value of a column/variable
		      
		    new.df[which(new.df$substrate.type == "A"), ] # choose rows to include by value of a column
		    new.df[which(new.df$substrate.type != "A"), ] # choose rows to exclude by value of a column
		    
		    new.df[,-1] # drop the first column
		    
		    new.df[, c(2,4)] # only include columns 1 & 4
		    
# &&&&&&&&&&&&&&&&&&&&&&&& Summarizing variables in data frames: &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&				  
	  	head(new.df)
		  # use statistical functions directly on a vector
		    
		    mean(new.df$snail.size) # calculate mean
		    median(new.df$snail.size) # calculate median
		    sd(new.df$snail.size) # calculate standard deviation
		    sum(new.df$snail.size) # calculate sum
		    length(new.df$snail.size) # count number of elements
		    
		    
		  # use summaryBy() function in the "doBy" package to summarize across particular variables
		    
		    summaryBy(snail.size ~ substrate.type, data = new.df) # defaults to calculating mean
		    
		    # Add more calculations
		    summaryBy(snail.size ~ substrate.type, data = new.df, FUN = list("mean", "sd", "length")) # use FUN (function) to customize which statistics to calculate
		    
		    # Add more dependant variables
		    summaryBy(snail.size ~ substrate.type + snail.color, data = new.df, FUN = list("mean", "sd", "length")) 
		    
		    new.df.sum = summaryBy(snail.size + snail.weight + snail.aggressiveness ~ substrate.type + snail.color, data = new.df, FUN = list("mean", "sd", "length")) 
		    new.df.sum
		    
# &&&&&&&&&&&&&&&&&&&&&&&& use "reshape2" package functions to convert between long & wide form data: &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&		    
		  
		    # use dcast() to convert long to wide data
		    
		   # new.df.wide =  
		   dcast(new.df, substrate.type ~ snail.color, value.var = "snail.size", fun.aggregate = length) # default summary is "length"
		   dcast(new.df, substrate.type ~ snail.color, value.var = "snail.size", fun.aggregate = mean) # change aggregation function to mean
		  #new.df.wide
		
		  # use melt() to convert wide to long data
		  
		  melt(data = new.df.wide, id.vars = c("substrate.type"), variable.name = "snail.color", value.name = "count")
		  
		

# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#  (5) plotting data:
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&	

	# base R plotting function:
		plot(x = df$var1, y = df$var2) # basic scatterplot
		plot(x = df$var1, y = df$var2, col = "red", pch = 16) # change color (col) & point shape (pch)
		
	# for more details: https://r-graph-gallery.com/6-graph-parameters-reminder.html		
		
	# *****plotting with ggplot**************	
	head(new.df)
	 # make an empty plot with correct variables on axes:
	ggplot(data = new.df, aes(x = transect.position, y = snail.size)) 
	
	# add points
	ggplot(data = new.df, aes(x = transect.position, y = snail.size)) +
	  geom_point(aes(col = substrate.type))
	
	# play with theme elements to change look of plot
	ggplot(data = new.df, aes(x = transect.position, y = snail.size)) +
	  geom_point(aes(col = substrate.type)) +
	  theme(panel.background = element_blank(),
	        axis.line = element_line(color = "black"),
	        text = element_text(size = 20))
	
	# change axis names and labels:
	ggplot(data = new.df, aes(x = transect.position, y = snail.size)) +
	  geom_point(aes(col = substrate.type)) +
	  theme(panel.background = element_blank(),
	        axis.line = element_line(color = "black"),
	        text = element_text(size = 20)) +
	  scale_x_continuous(name = "Transect position (m)", breaks = seq(-10, 20, by =2)) +
	  scale_y_continuous(name = "Snail size (mm)", breaks = seq(-10, 40, by = 5))
	
	# you can name a plot by assigning it as a variable, then continue to build the plot:
	plot = ggplot(data = new.df, aes(x = transect.position, y = snail.size)) + geom_point(aes(col = substrate.type)) + theme(panel.background = element_blank(), axis.line = element_line(color = "black"), text = element_text(size = 20)) + scale_x_continuous(name = "Transect position (m)", breaks = seq(-10, 20, by =2)) + scale_y_continuous(name = "Snail size (mm)", breaks = seq(-10, 40, by = 5))
	plot
	summary(lm(snail.size ~ transect.position, data = new.df)) # figure out the best fit linear model
	
	# manually add a best fit line using the stats you calculated
		plot + geom_line(y = df$transect.position*1.0639 + 11.08) 	
	
		?theme # open help menu to see all options for a function




	
	
	