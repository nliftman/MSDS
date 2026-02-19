#This code finds all regressions and determines their AIC
rm(list = ls())
setwd("~/Dropbox/Projects/CompletedProjects/Consulting/JoachimVoss/TimePoints")

#we need this library for the 'multinom' function
library(nnet)

data = read.csv("joachim-ic.csv",header=TRUE)
#ssc2 = SSC-W
#ssc4 = SSC-F

X = as.factor(data[,"ssc2"])
Y = as.factor(data[,"ssc4"])
time = as.factor(data[,"time"])
ic = data[,"ic"]

M1 = multinom(Y ~ 1)
AIC(M1)

M2 = multinom(Y ~ X)
AIC(M2)

M3 = multinom(Y ~ time)
AIC(M3)

M4 = multinom(Y ~ ic)
AIC(M4)

M5 = multinom(Y ~ X + time)
AIC(M5)

M6 = multinom(Y ~ X + ic)
AIC(M6)

M7 = multinom(Y ~ time + ic)
AIC(M7)

M8 = multinom(Y ~ X + time + ic)
AIC(M8)
#this is the minimum: aic = 2853.553

which.min(c(AIC(M1),AIC(M2),AIC(M3),AIC(M4),AIC(M5),AIC(M6),AIC(M7),AIC(M8)))

M9 = multinom(Y ~ X + time + ic + X:time)
AIC(M9)

M10 = multinom(Y ~ X + time + ic + X:ic)
AIC(M10)

M11 = multinom(Y ~ X + time + ic + time:ic)
AIC(M11)

M12 = multinom(Y ~ X + time + ic + X:time + X:ic)
AIC(M12)

M13 = multinom(Y ~ X + time + ic + X:time + time:ic)
AIC(M13)

M14 = multinom(Y ~ X + time + ic + X:ic + time:ic)
AIC(M14)

M15 = multinom(Y ~ X + time + ic + X:time + X:ic + time:ic)
AIC(M15)

#Logistic regressions for IC
L1 = glm(ic ~ 1,family = binomial(link = "logit"))
AIC(L1)

L2 = glm(ic ~ X,family = binomial(link = "logit"))
AIC(L2)

L3 = glm(ic ~ Y,family = binomial(link = "logit"))
AIC(L3)

L4 = glm(ic ~ time,family = binomial(link = "logit"))
AIC(L4)

L5 = glm(ic ~ X + Y,family = binomial(link = "logit"))
AIC(L5)

L6 = glm(ic ~ X + time,family = binomial(link = "logit"))
AIC(L6)

L7 = glm(ic ~ Y + time,family = binomial(link = "logit"))
AIC(L7)

L8 = glm(ic ~ X + Y + time,family = binomial(link = "logit"))
AIC(L8)

L9 = glm(ic ~ X + Y + X:Y,family = binomial(link = "logit"))
AIC(L9)
