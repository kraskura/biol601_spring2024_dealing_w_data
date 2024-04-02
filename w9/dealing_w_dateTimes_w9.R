# Author: Krista Kraskura
# Date: March 25, 2024
# Title: "Dealing with dates and Times in R"

# 1. Resources ------

# https://bookdown.org/rdpeng/rprogdatascience/dates-and-times.html
# https://www.stat.berkeley.edu/~s133/dates.html
# https://r4ds.had.co.nz/dates-and-times.html
# https://www.neonscience.org/resources/learning-hub/tutorials/dc-convert-date-time-posix-r


# 2. Libraries and setup ------ 
library(here)
library(lubridate) # will not deal with NAs in the data

here:::here("./w9/")
data_d <- read.csv(here("w9/Temp_HARV_Monthly_09_11.csv"))

# data from: https://www.neonscience.org/resources/learning-hub/tutorials/dc-convert-date-time-posix-r

# *****************************************************
# 3. Date Time formats ------
## 3.1. Date class: 'Date' ------
# (as a date since: 1970-01-01)
Sys.Date() # todays date

class("2025-03-25") # character
class(Sys.Date()) # date

# converting 
# from character to Date class. 
as.Date("2025-03-25") # good  
as.Date("2025/03/25") # good
as.Date("25-03-2024") # wrong
as.Date("25-03-2024", format = "%d-%m-%Y") # good
as.Date("25-Mar-2025") # error, must be a number for default 
as.Date("25-Mar-2025", format = "%d-%b-%Y") # good

?as.Date
as.Date("2025/03/04") # good, but what is it (march or april?) know your dates 


# *****************************************************
## 3.2. Time classes: 'POSIXct' or the 'POSIXlt' -------
# (calendar and local time, ct and lt, respectively) (as time of seconds since 1970-01-01)
Sys.time() # time (and date)

class("13:00:00 EDT") # character
class(Sys.time()) # date

# convert
as.POSIXlt("13:45:13") # error
# fixing it 
as.POSIXlt("2024-03-25 13:45:13 EDT") # good 
as.POSIXlt("2024-03-25 13:45:13") # good 
as.POSIXlt("2024-03-25 1:45:13 PM") # good? (24 clock?) 
as.POSIXlt("2024-03-25 1:45:13 PM", format = "%Y-%m-%d %I:%M:%S %p") # good 

?as.POSIXlt
unclass(as.POSIXlt(Sys.time())) # components of POSIXlt, can't do it with POSIXct


# *****************************************************
## 3.3. Converting your own date and time formats to a usable format.
strptime() # take a character vector and converts it into POSIXlt

strptime("25 Mar 2025 11:34:21", "%d %b %Y %H:%M:%S") 
strptime("25-03-25 11:34:21", "%d-%m-%y %H:%M:%S") 

?strptime # for complete list, common ones below
# %d = Day number of month (5, 17, 28, etc.)
# %j = Day number of the year (Julian day 001-366)
# %a = Abbreviated weekday (Mon, Tue, Wed, etc.)
# %A = Full weekday (Monday, Tuesday, etc.) 
# %m = Month number (e.g. 01, 02, 03, 04)
# %b = Abbreviated month (Jan, Feb, etc.)
# %B = Full month (January, February, etc.)
# %y = 2-digit year (e.g. 89)
# %Y = 4-digit year (e.g. 1989)
# %h = hours (24-hr clock)
# %m = minutes
# %s = seconds %z = offset from GMT
# %Z = Time zone (character)



# *****************************************************
# 4. Working with `lubridate` package ---------

today()
now()
date()
# print date

# three common ways to create a date/time:
## 4.1. From a string. --------
# specify the order of the components (day month hear)
ymd("2024-03-25")
mdy("March 25, 2024")
dmy("25-Mar-2024")
ymd(20240325)
ymd(240325)

# add time
ymd_h("2024-03-25 13")
ymd_hm("2024-03-25 13:05")
ymd_hms("2024-03-25 13:05:55")

# add timezone 
ymd_hms("2024-03-25 13:05:55", tz = "EST")

mdy("March 25, 2024")
dmy("25-Mar-2024")
ymd(20240325)
ymd(240325)

## 4.2. From individual date-time components. -------
# use make_date and make_datetime

head(data_d)

year<-"2024"
month<-"06"
make_date(year, month)

make_date(data_d$year, data_d$month)


## 4.3. From an existing date/time object, and extract components -----------
# use as_datetime() and as_date():
# extract date only or time only

as_datetime("2024-03-25") # has time now
as_date("2024-03-25 13:05:55") # only date 

example_datetime <- ymd_hms("2025-03-25 14:45:30")

hour(example_datetime)     # extract hour
minute(example_datetime)   # extract minute
second(example_datetime)   # extract second
year(example_datetime)     # extract year
month(example_datetime)    # extract month
yday(example_datetime)     # extract julian date

# 5. using dates and times -------
## 5.1. calculate differences



## 5.2. ggplot



# practice: 
# use lubridate to parse out these dates (from 'R for Data Science') 
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014


