#mediation analysis
rm(list = ls())
setwd("~/Dropbox/Projects/CompletedProjects/Consulting/JoachimVoss/TimePoints")

library(mediation)
library(MASS)

data = read.csv("joachim-ic.csv",header=TRUE)
#ssc2 = SSC-W
#ssc4 = SSC-F

Weakness = as.factor(data[,"ssc2"])
Fatigue = as.factor(data[,"ssc4"])
time = as.factor(data[,"time"])
ic = data[,"ic"]

#This is the model we propose in the paper
#Outcome model
model.y.Fatigue = polr(Fatigue ~ Weakness + time)
#Mediator model
model.m.Weakness = polr(Weakness ~ time)

med.out.Fatigue.1 = mediate(model.m = model.m.Weakness,
                          model.y = model.y.Fatigue,
                          treat = "time",
                          mediator = "Weakness",
                          boot = TRUE,
                          sims = 1000)

model.y.Fatigue = polr(Fatigue ~ Weakness + time + ic)
#Mediator model
model.m.Weakness = polr(Weakness ~ time + ic)

med.out.Fatigue.2 = mediate(model.m = model.m.Weakness,
                            model.y = model.y.Fatigue,
                            treat = "ic",
                            mediator = "Weakness",
                            boot = TRUE,
                            sims = 2500)


model.y.Weakness = polr(Weakness ~ Fatigue + time + ic)
#Mediator model
model.m.Fatigue = polr(Fatigue ~ time + ic)

med.out.Weakness.2 = mediate(model.m = model.m.Fatigue,
                            model.y = model.y.Weakness,
                            treat = "ic",
                            mediator = "Fatigue",
                            boot = TRUE,
                            sims = 2500)
