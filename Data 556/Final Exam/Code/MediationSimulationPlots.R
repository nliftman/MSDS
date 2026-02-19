#This code plots the simulation results from "MediationSimulation.R"
rm(list = ls())
setwd("~/Dropbox/Projects/CompletedProjects/Consulting/JoachimVoss/TimePoints")

library(ggplot2)

load("simulationResults.Rdata")

pdf('Figure5.pdf',width=10,height=5)
f <- ggplot(data.frame(x=factor(as.numeric(rownames(Results))),y=Results[,"Loglin"]), 
            aes(x=as.numeric(rownames(Results)),y=Results[,"Loglin"]))+
  geom_bar(stat = "identity",fill="white", colour="black")+
  xlab('Sample Size')+ 
  ylab('Model Identification Proportions')+
  ylim(c(0,1))+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle=0, hjust=1)) + theme_bw(base_size = 20)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
plot(f)
dev.off()

pdf('Figure6.pdf',width=10,height=5)
f <- ggplot(data.frame(x=factor(as.numeric(rownames(Results))),y=Results[,"X1"]), 
            aes(x=as.numeric(rownames(Results)),y=Results[,"X1"]))+
  geom_bar(stat = "identity",fill="white", colour="black")+
  xlab('Sample Size')+ 
  ylab('Model Identification Proportions')+
  ylim(c(0,1))+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle=0, hjust=1)) + theme_bw(base_size = 20)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
plot(f)
dev.off()

pdf('Figure7.pdf',width=10,height=5)
f <- ggplot(data.frame(x=factor(as.numeric(rownames(Results))),y=Results[,"X2"]), 
            aes(x=as.numeric(rownames(Results)),y=Results[,"X2"]))+
  geom_bar(stat = "identity",fill="white", colour="black")+
  xlab('Sample Size')+ 
  ylab('Model Identification Proportions')+
  ylim(c(0,1))+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle=0, hjust=1)) + theme_bw(base_size = 20)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
plot(f)
dev.off()

pdf('Figure8.pdf',width=10,height=5)
f <- ggplot(data.frame(x=factor(as.numeric(rownames(Results))),y=Results[,"IC"]), 
            aes(x=as.numeric(rownames(Results)),y=Results[,"IC"]))+
  geom_bar(stat = "identity",fill="white", colour="black")+
  xlab('Sample Size')+ 
  ylab('Model Identification Proportions')+
  ylim(c(0,1))+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle=0, hjust=1)) + theme_bw(base_size = 20)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
plot(f)
dev.off()

pdf('Figure9.pdf',width=10,height=5)
f <- ggplot(data.frame(x=factor(as.numeric(rownames(Results))),y=Results[,"X1X2IC"]), 
            aes(x=as.numeric(rownames(Results)),y=Results[,"X1X2IC"]))+
  geom_bar(stat = "identity",fill="white", colour="black")+
  xlab('Sample Size')+ 
  ylab('Model Identification Proportions')+
  ylim(c(0,1))+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle=0, hjust=1)) + theme_bw(base_size = 20)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
plot(f)
dev.off()
