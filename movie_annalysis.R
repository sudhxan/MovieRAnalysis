getwd()
setwd("E:\\R\\Section 6")
getwd()

#Data Layer: 1
movies <- read.csv("P2-Movie-Ratings.csv", stringsAsFactors = T) #This is set to true because, it reduces memory and can be helpful in running statistical models.
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRatings","AudienceRatings", "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies) #R is treating year as a numerical value

#Converting Year into a factor
factor(movies$Year) 
movies$Year <- factor(movies$Year)
str(movies) #Year is now a factor

#Aesthetics Layer:2
library(ggplot2)
ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre, size=BudgetMillions))

#Geometry Layer: 3
ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre, size=BudgetMillions)) +
  geom_point()

#Adding aesthetics as a variable and stacking various geometries
p <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre, size=BudgetMillions))
p + geom_point() + geom_line()

#Overrideing Aesthetics
q <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre, size=BudgetMillions))

#Add geom layer
q + geom_point()

q + geom_point(aes(size=CriticRatings)) #size is now based on critic ratings

q + geom_point(aes(colour=BudgetMillions)) #color is now based on Budget

q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions $$$")             ##x axis is Budget now

q + geom_line(size=1) + geom_point()     ##changed the size of line to 1 from 3, but note we did not add the aes() function here!!!!

#Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings))
r + geom_point()

#Add colour
#1. Mapping
r + geom_point(aes(colour=Genre))
#2. Setting
r + geom_point(colour="Yellow")
#Do you see the difference? If we want to define a colour then we don't use the aes() function
#But if we are required to map a feature from the dataframe then we use aes() function
#ERROR:
r + geom_point(aes(colour="Yellow")) #It takes Yellow as a category


#1.Mapping
r + geom_point(aes(size=BudgetMillions))
#2.Setting
r + geom_point(size=10)
#ERROR
r + geom_point(aes(size=10))

# Histograms and Density Charts

s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth = 20)

#Adding colour to our Histogram based on Genre of the movie
s + geom_histogram(binwidth = 10, aes(fill=Genre))

#Adding border to the bins
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#Density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position = "stack") # we have the graphs of genres stack over each other.

# Layering tips
t <- ggplot(data=movies, aes(x=AudienceRatings))
t + geom_histogram(binwidth = 10, fill="White", colour="Blue")

#Another way of performing the above
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, 
                   aes(x=AudienceRatings), 
                   fill="White", colour="Blue")

t + geom_histogram(binwidth = 10,
                   aes(x=CriticRatings),
                   fill="White", colour="Blue") #Univform Distribution

#Statistical Transformations
t <- ggplot()
?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings,
                            colour=Genre))

u + geom_point() + geom_smooth()

u + geom_point() + geom_smooth(fill=NA)

#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRatings, colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2) + geom_point()
#Wider boxplot with less points in the box means less certainity.
u + geom_boxplot(size=1.2) + geom_jitter()
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#boxplot for critic ratings
u <- ggplot(data=movies, aes(x=Genre, y=CriticRatings, colour=Genre))
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#Using Facets
library(ggplot2)
v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black")

#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales="free")

w <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, 
                             colour=Genre))

w + geom_point(size=3)
#Facets
w + geom_point(size=3) + facet_grid(Genre~., scale="free")
w + geom_point(size=3) + facet_grid(~Year, scale="free")
w + geom_point(size=3) + facet_grid(Genre~Year, scale="free")
w + geom_point(aes(size=BudgetMillions)) + geom_smooth() + facet_grid(Genre~Year, scale="free")


#Cartesian coords - zooming
w + geom_point(aes(size=BudgetMillions)) + geom_smooth() + 
  facet_grid(Genre~Year, scale="free") +
  coord_cartesian(ylim=c(0,150))

#Themes
o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre),colour="Black")

#add labels x and y axis
h + xlab("Money Axis") + ylab("Number of movies") +
  theme(axis.title.x= element_text(colour="DarkGreen", size=20),
        axis.title.y= element_text(colour="Red", size= 20))

#tick mark formatting
h + xlab("Money Axis") + ylab("Number of movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x= element_text(colour="DarkGreen", size=20),
        axis.title.y= element_text(colour="Red", size= 20),
        axis.text.x = element_text(size=15),
        axis.text.y= element_text(size=15),
        legend.title=element_text(size=20),
        legend.text=element_text(size=15),
        legend.position= c(1,1),
        legend.justification = c(1,1),
        plot.title=element_text(colour="DarkBlue",
                                size=30))
