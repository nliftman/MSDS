#This code finds all regressions and determines their AIC
rm(list = ls())
#setwd("~/Dropbox/Projects/CompletedProjects/Consulting/JoachimVoss/TimePoints")
setwd("~/Desktop/Parallels Shared Folders/Dropbox/Projects/CompletedProjects/Consulting/JoachimVoss/TimePoints")

library(nnet)
#for multinom
library(gRim)

tableDimens = c(4,4,2)
         
sampleSize = seq(from=100,to=1500,by=50)
nReplicates = 1000
variableNames = list()
variableNames[["X1"]] = seq(from=0,to=tableDimens[1]-1,by=1)
variableNames[["X2"]] = seq(from=0,to=tableDimens[2]-1,by=1)
variableNames[["IC"]] = seq(from=0,to=tableDimens[3]-1,by=1)

targetModelMargins = list(c(1,2),c(2,3))
targetModel = "~ X1:X2 + X2:IC"

AllModels = c("~ X1 + X2 + IC",
              "~ X1:X2 + IC",
              "~ X1 + X2:IC",
              "~ X1:IC + X2",
              "~ X1:X2 + X2:IC",
              "~ X1:X2 + X1:IC",
              "~ X1:IC + X2:IC",
              "~ X1:X2 + X2:IC + X1:IC")
regsX1 = c("X1 ~ 1",
           "X1 ~ X2",
           "X1 ~ IC",
           "X1 ~ X2 + IC")
targetModelX1 = regsX1[2]

regsX2 = c("X2 ~ 1",
           "X2 ~ X1",
           "X2 ~ IC",
           "X2 ~ X1 + IC")
targetModelX2 = regsX2[4]

regsIC = c("IC ~ 1",
           "IC ~ X1",
           "IC ~ X2",
           "IC ~ X1 + X2")
targetModelIC = regsIC[3]

simulateTable = function(tableDimens,sampleSize,targetModelMargins)
{
  p = runif(prod(tableDimens))
  tableProbs = p/sum(p)
  tableCounts = rmultinom(n=1,size = sampleSize,prob = tableProbs)
  rawTable = as.table(array(tableCounts, dim=tableDimens, dimnames=variableNames))
  rawLoglin = loglin(table = rawTable,margin = targetModelMargins,fit = TRUE,print = FALSE)
  tableCounts = rmultinom(n=1,size = sampleSize,prob = as.data.frame(rawLoglin$fit)[,"Freq"]/sampleSize)
  simTable = as.table(array(tableCounts, dim=tableDimens, dimnames=variableNames))
  return(simTable)
}

correctLoglin = numeric(length = length(sampleSize))
correctX1 = numeric(length = length(sampleSize))
correctX2 = numeric(length = length(sampleSize))
correctIC = numeric(length = length(sampleSize))
correctX1X2IC = numeric(length = length(sampleSize))

for(i in seq_len(length(sampleSize)))
{
  cat("Working ",i," sample size ",sampleSize[i],"\n")
  for(arep in seq(from=1,to=nReplicates,by=1))
  {
    simTable = simulateTable(tableDimens,sampleSize[i],targetModelMargins)
    loglinSelection = sapply(AllModels,function(x) { AIC(dmod(formula = formula(x),data = simTable))})
    if(names(which.min(loglinSelection))==targetModel)
    {
      correctLoglin[i] = correctLoglin[i]+1
    }
    
    regX1Selection = sapply(regsX1,function(x) { AIC(multinom(formula = formula(x),data = as.data.frame(simTable),weights = Freq)) })
    if(names(which.min(regX1Selection))==targetModelX1)
    {
      correctX1[i] = correctX1[i]+1
    }
    
    regX2Selection = sapply(regsX2,function(x) { AIC(multinom(formula = formula(x),data = as.data.frame(simTable),weights = Freq)) })
    if(names(which.min(regX2Selection))==targetModelX2)
    {
      correctX2[i] = correctX2[i]+1
    }
    
    regICSelection = sapply(regsIC,function(x) { AIC(glm(formula = formula(x),family = binomial(link = "logit"),data = as.data.frame(simTable),weights = Freq)) })
    if(names(which.min(regICSelection))==targetModelIC)
    {
      correctIC[i] = correctIC[i]+1
    }
    
    if((names(which.min(regX1Selection))==targetModelX1)&
       (names(which.min(regX2Selection))==targetModelX2)&
       (names(which.min(regICSelection))==targetModelIC)
      )
    {
      correctX1X2IC[i] = correctX1X2IC[i] + 1
    }
  }
}

correctLoglin = correctLoglin/nReplicates
correctX1 = correctX1/nReplicates
correctX2 = correctX2/nReplicates
correctIC = correctIC/nReplicates
correctX1X2IC = correctX1X2IC/nReplicates
Results = cbind(correctLoglin,correctX1,correctX2,correctIC,correctX1X2IC)
colnames(Results) = c("Loglin","X1","X2","IC","X1X2IC")
rownames(Results) = sampleSize

save(Results,file="simulationResults.Rdata")

