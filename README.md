Data Products Course Project
===
##Project summary

The idea of the application is datamining Github.com site via its public API to get some interesting data.

It is found that it is possible to estimate the number of the coursera students that participate Data Science specialization courses every month by quering Github.

Course assignment involves forking particular github reprository. So, each student participating the course have to fork that reposotory. This can help to retrieve the number of students participating online course.

### Data Mining

- GutHub public API allows to retrieve data about users that have forked the particular repository

- The following chunk of R code illustare Guthub fork API usage
```
library(httr)
# retrieve one page of the result
url <- "https://api.github.com/repos/rdpeng/ExData_Plotting1/forks?page=2"
req <- GET(url, authenticate("gtihubuser", "githubpassword"))
# retrieve list of users and list of fork dates
content <- content(req)
# list of users id
users <- content$owner$id
# list of reprostory fork time
created <- content$created_at
```
- Actual source code for Guthub mining
(https://github.com/dperov/DevelopingDataProducts_CourseProject/blob/master/load.R)

### Data Processing

- The following github repositories are quered:
* https://api.github.com/repos/jtleek/datasharing/forks
* https://github.com/rdpeng/ProgrammingAssignment2
* https://github.com/rdpeng/RepData_PeerAssessment1
* https://github.com/rdpeng/ExData_Plotting1

- GitHub fork API returns a lot of information. For our purposes only 2 parameters are used: user Id and forking date.
- Row data are merged into single data frame. User data then is aggregated by month and course
- Final dataset appearance:
```
> head(data_agg)
       month course    x
1 2014-02-01     ex    2
2 2014-05-01     ex 3043
3 2014-06-01     ex 1744
4 2014-07-01     ex 1994
5 2014-08-01     ex 1642
6 2014-09-01     ex 1616
```
- actual code for data processing
(https://github.com/dperov/DevelopingDataProducts_CourseProject/blob/master/process.R)

### Results

- Data processing result: number of students for some Coursera cousers
![](/Screenshot_2.png)


### Data Application

- Simple Shiny web data application created for data visualization
![](/Screenshot_1.png)


##Github repository content

* load.R

Code for loading informatin about github users that fork particular repository

* process.R

Processed of row data to obtain final dataset

* README.md

This file 

* server.R
* ui.R
* data/couses_data.table

Source codes of the Shiny application

* CourseProjectPresentation.Rpres

Project presentation source

* CourseProjectPresentation.html

Project presentation


##References
GitHub public API
(https://developer.github.com/v3/)

Application presentation
(https://dperov.github.io/DevelopingDataProducts_CourseProject/CourseProjectPresentation.html#/)

Application Sources
(https://github.com/dperov/DevelopingDataProducts_CourseProject)

Application online on shinyapps.io
(https://dperov.shinyapps.io/DevelopingDataProducts_CourseProject/)

Application presentation on RPubs
(http://rpubs.com/dperov/DevelopingDataProducts_CourseProject)