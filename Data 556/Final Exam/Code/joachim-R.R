data = read.csv("joachim.csv",header=TRUE);

#First analysis: ignore the groups
#Please note that each group is identified by "site" (column 1)
# AND patient id (column 2)

#create a 3-way contingency table with variables
#1 = ssc2
#2 = ssc4
#3 = time

mytable = table(data[,c(4,5,3)]);

> mytable
, , time = 0

      ssc4
ssc2   0   1   2   3
0     152  26  32  19
1     22   74  46  14
2     14   20  87  36
3     12   1   16  53

, , time = 1

      ssc4
ssc2   0   1   2   3
0     203  29  32  20
1     16   47  29   5
2     14   13  75  19
3     8    0   8  36

, , time = 2

      ssc4
ssc2   0   1   2   3
0     160  24  27   6
1     16   36  24   3
2     9    11  36   8
3     7    3   5  29

#Model 1
indep.loglin = loglin(mytable,margin=list(1,2,3),fit=TRUE,param=TRUE);
1-pchisq(indep.loglin$lrt,indep.loglin$df)
[1] 0
#does not fit the data well

#Model 2
X1indepX2X3.loglin = loglin(mytable,margin=list(1,c(2,3)),fit=TRUE,param=TRUE)
1-pchisq(X1indepX2X3.loglin$pearson,X1indepX2X3.loglin$df)
[1] 0
#does not fit the data well

#Model 3
X2indepX1X3.loglin = loglin(mytable,margin=list(2,c(1,3)),fit=TRUE,param=TRUE)
1-pchisq(X2indepX1X3.loglin$pearson,X2indepX1X3.loglin$df)
[1] 0
#does not fit the data well

#Model 4
X3indepX1X2.loglin = loglin(mytable,margin=list(3,c(1,2)),fit=TRUE,param=TRUE)
1-pchisq(X3indepX1X2.loglin$pearson,X3indepX1X2.loglin$df)
[1] 0.0001060582
#does not fit the data well

#Model 5
X2indepX3givenX1.loglin = loglin(mytable,margin=list(c(1,2),c(1,3)),fit=TRUE,param=TRUE)
1-pchisq(X2indepX3givenX1.loglin$lrt,X2indepX3givenX1.loglin$df)
[1] 0.3490901
#THIS MODEL FITS THE DATA WELL

#Model 6
X1indepX3givenX2.loglin = loglin(mytable,margin=list(c(1,2),c(2,3)),fit=TRUE,param=TRUE)
1-pchisq(X1indepX3givenX2.loglin$lrt,X1indepX3givenX2.loglin$df)
[1] 0.07301353
#THIS MODEL FITS THE DATA WELL

#Model 7
X1indepX2givenX3.loglin = loglin(mytable,margin=list(c(1,3),c(2,3)),fit=TRUE,param=TRUE)
1-pchisq(X1indepX2givenX3.loglin$lrt,X1indepX2givenX3.loglin$df)
#this model does not fit the data well

#Model 8
no2nd.loglin = loglin(mytable,margin=list(c(1,2),c(1,3),c(2,3)),fit=TRUE,param=TRUE)
1-pchisq(no2nd.loglin$lrt,no2nd.loglin$df)
[1] 0.7020021
#THIS MODEL FITS THE DATA WELL

#There are three models that fit the data well: 5, 6 and 8

#compare models 5 and 8
1-pchisq(X2indepX3givenX1.loglin$lrt-no2nd.loglin$lrt,X2indepX3givenX1.loglin$df-no2nd.loglin$df)
[1] 0.06973396
#We prefer model 8 and eliminate model 5 

#compare models 6 and 8
1-pchisq(X1indepX3givenX2.loglin$lrt-no2nd.loglin$lrt,X1indepX3givenX2.loglin$df-no2nd.loglin$df)
[1] 0.002461097
#We prefer model 6 and eliminate model 8

#Our preferred loglinear model is: Model 6, the model of conditional independence of
#ssc2 and time given ssc4

#1 = ssc2
#2 = ssc4
#3 = time

#SECOND ANALYSIS: take ordering into account using copula GGMs
stu3:~/Copula/Examples/Joachim> more ssc2ssc4time.txt.edges.txt 
        ssc2     ssc4     time
ssc2    0.00000  1.00000	0.25551
ssc4    1.00000	0.00000	0.89461
time    0.25551	0.89461	0.00000

ssc2 ssc4 time CopulaGGM Model6
1  1	1	152.00	156.22 162.72
1	1	2	203.00	173.17 196.07
1	1	3	160.00	151.77 156.21
1	2	1	26.00	49.95 33.66
1	2	2	29.00	46.07 24.76
1	2	3	24.00	33.67 20.58
1	3	1	32.00	42.96 39.5
1	3	2	32.00	36.13 31.42
1	3	3	27.00	24.07 20.08
1	4	1	19.00	7.35 22.14
1	4	2	20.00	5.32 14.52
1	4	3	6.00	3.15 8.35
2	1	1	22.00	35.70 17.06
2	1	2	16.00	36.22 20.56
2	1	3	16.00	28.86 16.38
2	2	1	74.00	31.57 66.89
2	2	2	47.00	28.62 49.2
2	2	3	36.00	20.22 40.91
2	3	1	46.00	49.02 42.97
2	3	2	29.00	39.95 34.19
2	3	3	24.00	25.77 21.84
2	4	1	14.00	17.18 10.82
2	4	2	5.00	12.13 7.1
2	4	3	3.00	6.96 4.08
3	1	1	14.00	16.77 11.69
3	1	2	14.00	16.51 14.09
3	1	3	9.00	12.72 11.22
3	2	1	20.00	24.69 18.75
3	2	2	13.00	21.73 13.79
3	2	3	11.00	15.21 11.46
3	3	1	87.00	62.41 85.94
3	3	2	75.00	49.49 68.37
3	3	3	36.00	31.36 43.68
3	4	1	36.00	44.37 30.99
3	4	2	19.00	30.06 20.32
3	4	3	8.00	16.64 11.69
4	1	1	12.00	1.91 8.53
4	1	2	8.00	1.82 10.28
4	1	3	7.00	1.34 8.19
4	2	1	1.00	5.07 1.70
4	2	2	0.00	4.40 1.25
4	2	3	3.00	2.96 1.04
4	3	1	16.00	25.07 12.59
4	3	2	8.00	19.02 10.01
4	3	3	5.00	11.61 6.4
4	4	1	53.00	53.65 58.05
4	4	2	36.00	33.69 38.06
4	4	3	29.00	17.46 21.89

#create one index out of site and patient id
myindex = data[,1]*1000+data[,2];

uniqueIndex = unique(myindex);
nPatients = length(uniqueIndex); #710 patients
mycounts = numeric(nPatients);

for(i in 1:nPatients)
{
  mycounts[i] = length(myindex[myindex==uniqueIndex[i]]);
}

tabulate(mycounts)
[1] 163 222 325

#There are 163 patients with 1 time point observed
# 222 patients with 2 time points observed
# and 325 patients with 3 time points observed

#Fit ordinal regressions for ssc4
> orderM = polr(factor(ssc4) ~ factor(ssc2)+factor(time)+factor(ssc2)*factor(time))
> orderM
Call:
  polr(formula = factor(ssc4) ~ factor(ssc2) + factor(time) + factor(ssc2) * 
  factor(time))

Coefficients:
  factor(ssc2)1               factor(ssc2)2 
1.50035976                  2.57263546 
factor(ssc2)3               factor(time)1 
3.92850473                 -0.26976227 
factor(time)2 factor(ssc2)1:factor(time)1 
-0.43725970                  0.12855686 
factor(ssc2)2:factor(time)1 factor(ssc2)3:factor(time)1 
0.07445656                  0.47179468 
factor(ssc2)1:factor(time)2 factor(ssc2)2:factor(time)2 
0.20674830                 -0.01919128 
factor(ssc2)3:factor(time)2 
0.36880790 

Intercepts:
  0|1       1|2       2|3 
0.5367759 1.5902932 3.4915790 

Residual Deviance: 3456.545 
AIC: 3484.545 

> orderM = polr(factor(ssc4) ~ factor(time)
                + )
> orderM
Call:
  polr(formula = factor(ssc4) ~ factor(time))

Coefficients:
  factor(time)1 factor(time)2 
-0.4069661    -0.6218775 

Intercepts:
  0|1         1|2         2|3 
-0.71118443  0.02684338  1.40402569 

Residual Deviance: 4134.76 
AIC: 4144.76 

> orderM = polr(factor(ssc4) ~ factor(ssc2))
> orderM
Call:
  polr(formula = factor(ssc4) ~ factor(ssc2))

Coefficients:
  factor(ssc2)1 factor(ssc2)2 factor(ssc2)3 
1.633725      2.642942      4.193069 

Intercepts:
  0|1       1|2       2|3 
0.7694551 1.8200359 3.7135626 

Residual Deviance: 3465.812 
AIC: 3477.812 

> orderM = polr(factor(ssc4) ~ factor(ssc2) + factor(time))
> orderM
Call:
  polr(formula = factor(ssc4) ~ factor(ssc2) + factor(time))

Coefficients:
  factor(ssc2)1 factor(ssc2)2 factor(ssc2)3 factor(time)1 
1.6007231     2.6063454     4.1668754    -0.1674844 
factor(time)2 
-0.3399592 

Intercepts:
  0|1       1|2       2|3 
0.6036644 1.6568541 3.5562872 

Residual Deviance: 3458.361 
AIC: 3474.361 
#THIS MODEL FITS DATA BEST

#Ordinal regressions for SSC2
> orderM = polr(factor(ssc2) ~ factor(ssc4)+factor(time)+factor(ssc4)*factor(time))
> orderM
Call:
  polr(formula = factor(ssc2) ~ factor(ssc4) + factor(time) + factor(ssc4) * 
  factor(time))

Coefficients:
  factor(ssc4)1               factor(ssc4)2 
1.603952025                 2.458005508 
factor(ssc4)3               factor(time)1 
3.620693294                -0.548453061 
factor(time)2 factor(ssc4)1:factor(time)1 
-0.493819261                 0.285634180 
factor(ssc4)2:factor(time)1 factor(ssc4)3:factor(time)1 
0.443299435                 0.413013972 
factor(ssc4)1:factor(time)2 factor(ssc4)2:factor(time)2 
0.332170555                 0.006994144 
factor(ssc4)3:factor(time)2 
1.333839009 

Intercepts:
  0|1      1|2      2|3 
1.070264 2.341151 4.136533 

Residual Deviance: 3267.249 
AIC: 3295.249 

> orderM = polr(factor(ssc2) ~ factor(ssc4)+factor(time))
> orderM
Call:
  polr(formula = factor(ssc2) ~ factor(ssc4) + factor(time))

Coefficients:
  factor(ssc4)1 factor(ssc4)2 factor(ssc4)3 factor(time)1 
1.7959637     2.6282173     4.0158638    -0.2415246 
factor(time)2 
-0.2108173 

Intercepts:
  0|1      1|2      2|3 
1.259358 2.525335 4.305473 

Residual Deviance: 3281.521 
AIC: 3297.521 

> orderM = polr(factor(ssc2) ~ factor(ssc4))
> orderM
Call:
  polr(formula = factor(ssc2) ~ factor(ssc4))

Coefficients:
  factor(ssc4)1 factor(ssc4)2 factor(ssc4)3 
1.821356      2.650492      4.053554 

Intercepts:
  0|1      1|2      2|3 
1.412867 2.675439 4.455078 

Residual Deviance: 3286.538 
AIC: 3298.538 

> orderM = polr(factor(ssc2) ~ factor(time))
> orderM
Call:
  polr(formula = factor(ssc2) ~ factor(time))

Coefficients:
  factor(time)1 factor(time)2 
-0.4694953    -0.5820931 

Intercepts:
  0|1        1|2        2|3 
-0.4643931  0.4195661  1.7814586 

Residual Deviance: 3960.541 
AIC: 3970.541 