rm(list=ls())
data = read.csv("joachim-ic.csv",header=TRUE);
mytable = table(data[,c("ssc2","ssc4","time")]);

nTries = 10000
propSamples = seq(from=0.01,to=0.99,by=0.01)
library(gRim)

#functions that checks if two models are the same
#the models are stored as lists
isSameModel = function(m1,m2)
{
  len1 = length(m1)
  len2 = length(m2)
  if(len1!=len2) return(FALSE)
  
  M1 = lapply(m1,sort)
  M2 = lapply(m2,sort)
  
  return(all(sapply(M1,function(x){ any(sapply(M2, function(y)(all(x==y)))) })))
}

M1Three = dmod(~ssc2+ssc4+time,data=mytable)
M2Three = stepwise(M1Three,type="unrestricted",criterion="aic",search="all",direction="forward")

propThree = numeric(length(propSamples))
for(j in seq_len(length(propSamples)))
{
  mycount = 0
  for(i in seq_len(nTries))
  {
    atable = table(data[sample.int(nrow(data),size=propSamples[j]*nrow(data)),c("ssc2","ssc4","time")])
    
    aM1forward = dmod(~ssc2+ssc4+time,data=atable)
    aM2forward = stepwise(aM1forward,type="unrestricted",criterion="aic",search="all",direction="forward")
    
    aM1backward = dmod(~.^.,data=atable)
    aM2backward = stepwise(aM1backward,type="unrestricted",criterion="aic",search="all",direction="backward")
    
    if(isSameModel(aM2forward$glist,M2Three$glist)&&isSameModel(aM2backward$glist,M2Three$glist))
    {
      mycount = mycount+1
    }
  }
  propThree[j] = mycount/nTries
}

save(M1Three,M2Three,propThree,file="models3vars.Rdata")
