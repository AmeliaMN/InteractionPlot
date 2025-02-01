# The idea of this file is to illustrate the problems that can occur when you cut a continuous variable into a number of discrete categorical variables. 
# We'll be working with API data, from California schools in 2013. This is just a small random sample of the complete data set, because that data is large.

# To start, load the data
d1 <- read.csv("miniAPI.csv")


# Lets make a simple model, with two variables and an interaction effect
m1 <- lm(API13~AVG_ED+SD_SIG+AVG_ED*SD_SIG, data=d1)
summary(m1)
# All the variables are significant (there are problems with multicolinearity between the variables, which is a separate issue I'm going to ignore here) and here's the 
# interpretation of the coefficients:
# "For a one-unit increase in average parent education, we expect to see an increase in 2013 API on average of 133.7 points."
# "Compared to schools that do not have a significant number of socioeconomically disadvantaged students, schools with a significant number of socioeconomically 
# disadvantaged students have API scores that are on average 226 points higher"
# "For schools that have a significant number of scoioeconimically disadvantaged students, the effect of average parent education level is reduced by 56 points. 
# In other words, for schools classified as having a significant number of disadvantaged students, the increase in API score for a one-unit increase in average 
# parent education would be on average 77.7 points"

# To see that last effect, we want to be able to make an interaction plot, but interaction plots are hard to interpret with numeric variables. 
# Just to see that, lets try it:
interaction.plot(d1$AVG_ED, d1$SD_SIG, d1$API13)


# So, we're going to turn the numeric variable into a categorical one.
summary(d1$AVG_ED)
mean(d1$AVG_ED, na.rm=TRUE)
d1$ab_avg <- rep(NA, length(d1$AVG_ED))
d1$ab_avg[d1$AVG_ED>=mean(d1$AVG_ED, na.rm=TRUE)] <- "Above"
d1$ab_avg[d1$AVG_ED<mean(d1$AVG_ED, na.rm=TRUE)] <- "Below"
d1$ab_avg <- factor(d1$ab_avg)
summary(d1$ab_avg)

# Now we'll run the model again, with the new variables
m2 <- lm(API13~ab_avg+SD_SIG+ab_avg*SD_SIG, data=d1)
summary(m2)
# Everything is still significant, but the coefficients have changed, and so has the interpretation. 
# "Compared to schools whose average parent education is above average, schools with below-average average parent education (say that five times fast) score 
# on average 215 points lower on API"
# "Compared to schools who do not have a significant number of disadvantaged students, schools that do, have API scores on average 15 points lower."
# "The effect of average education on API score is not the same for schools that have a significant number of disadvantaged students and those who do not. 
# Instead of being on average 215 points lower (compared to those with above-average parent education), schools with a significant number of disadvantaged students 
# have API scores on average 88 points lower. That is, the effect of parent education is not as large in disadvantaged schools."

# Now we can look at the interaction plot. 
interaction.plot(d1$ab_avg, d1$SD_SIG, d1$API13)
# Notice that the lines are crossing ("there is an interaction effect"), but that even if we switch which variable is on the x-axis, we see the effect disappear:
interaction.plot(d1$SD_SIG, d1$ab_avg, d1$API13)
# This is because of the change in interpetation. 

# But worse than that, if we adjust the cutoff value for the variable that we turned into a categorical variable, we can change the effect. 
# For example, lets say that we thought it was important whether the school's average parent education level was above the 1st quartile or not.
d1$in_q1 <- rep(NA, length(d1$AVG_ED))
d1$in_q1[d1$AVG_ED>=2.16] <- "not in 1st quartile"
d1$in_q1[d1$AVG_ED<2.16] <- "in 1st quartile"


m3 <- lm(API13~in_q1+SD_SIG+in_q1*SD_SIG, data=d1)
summary(m3)
# I'm not going to write out the interpretation here, because it's much the same as above. However, notice the sign change. 
# (Part of that is due to colinearity making these parameter estimates unstable)

# Lets look at that interaction plot
interaction.plot(d1$in_q1, d1$SD_SIG, d1$API13)
# The effect has completely switched! 