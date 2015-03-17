<!--
    https://rstudio-pubs-static.s3.amazonaws.com/35364_334944a02fcf4792b232aacbfee2f6e6.html
    https://rpubs.com/roozbehdavari/33121
-->
# Assessing the ToothGrowth Dataset with R
#### Author: Danilo Mutti



The [ToothGrowth dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/ToothGrowth.html) (TG) contains data about the effect of vitamin C on tooth growth in Guinea pigs. In this study, the response is the length of odontoblasts (teeth) in each of 10 guinea pigs at each of three dose levels of Vitamin C (0.5, 1, and 2 mg) with each of two delivery methods (orange juice or ascorbic acid).

The dataset contains a data frame with 60 observations on 3 variables.

|column index|column name| type      | description |
|------------|-----------|-----------|-------------|
| [,1]       | len	     | numeric	 |Tooth length |
| [,2]       | supp	     | factor    | Supplement type (VC or OJ).|
| [,3]       | dose      | numeric   | Dose in milligrams.|

We start by loading the dataset, followed by a basic exploration of how the data is structured.


```r
data(ToothGrowth)
str(ToothGrowth)
```

```
## 'data.frame':	60 obs. of  3 variables:
##  $ len : num  4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
##  $ supp: Factor w/ 2 levels "OJ","VC": 2 2 2 2 2 2 2 2 2 2 ...
##  $ dose: num  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
```

```r
summary(ToothGrowth)
```

```
##       len        supp         dose      
##  Min.   : 4.20   OJ:30   Min.   :0.500  
##  1st Qu.:13.07   VC:30   1st Qu.:0.500  
##  Median :19.25           Median :1.000  
##  Mean   :18.81           Mean   :1.167  
##  3rd Qu.:25.27           3rd Qu.:2.000  
##  Max.   :33.90           Max.   :2.000
```

The following figure *seems to indicate* that orange juice (OJ) is more effective for lower/intermediate dose levels. When dose levels are higher, the effectiveness between OJ and Vitamin C (VC) *seems to be similar*, with OJ presenting more consistent results.


```r
coplot(len ~ dose | supp, data = ToothGrowth, panel = panel.smooth,
       xlab = "ToothGrowth data: length vs dose, given type of supplement")
```

![](course_project_b_figure/unnamed-chunk-3-1.png) 


## Data Processing

In this dataset, rows 1 to 10 correspond to the observations from Guinea pigs 1 to 10. The eleventh row contains another observation of Guinea pig number 1, and so on. In order to tidy this dataset, we are going to fit it into 6 columns and 10 rows. Each row corresponds to one specific Guinea pig, and each column represents a supplement (VC or OJ) and its associated dose (0.5, 1.0 or 2.0).


```r
VC_05 <- ToothGrowth$len[1:10]
VC_10 <- ToothGrowth$len[11:20]
VC_20 <- ToothGrowth$len[21:30]
OJ_05 <- ToothGrowth$len[31:40]
OJ_10 <- ToothGrowth$len[41:50]
OJ_20 <- ToothGrowth$len[51:60]
print(tidy <- data.frame(VC_05, VC_10, VC_20, OJ_05, OJ_10, OJ_20))
```

```
##    VC_05 VC_10 VC_20 OJ_05 OJ_10 OJ_20
## 1    4.2  16.5  23.6  15.2  19.7  25.5
## 2   11.5  16.5  18.5  21.5  23.3  26.4
## 3    7.3  15.2  33.9  17.6  23.6  22.4
## 4    5.8  17.3  25.5   9.7  26.4  24.5
## 5    6.4  22.5  26.4  14.5  20.0  24.8
## 6   10.0  17.3  32.5  10.0  25.2  30.9
## 7   11.2  13.6  26.7   8.2  25.8  26.4
## 8   11.2  14.5  21.5   9.4  21.2  27.3
## 9    5.2  18.8  23.3  16.5  14.5  29.4
## 10   7.0  15.5  29.5   9.7  27.3  23.0
```

## Appendix

This section contains the environment in which this report was produced.


```r
sessionInfo()
```

```
## R version 3.1.2 (2014-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## 
## locale:
## [1] C
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] reshape2_1.4.1 dplyr_0.3.0.2  ggplot2_1.0.0 
## 
## loaded via a namespace (and not attached):
##  [1] DBI_0.3.1        MASS_7.3-35      Rcpp_0.11.3      assertthat_0.1  
##  [5] colorspace_1.2-4 digest_0.6.6     evaluate_0.5.5   formatR_1.0     
##  [9] grid_3.1.2       gtable_0.1.2     htmltools_0.2.6  knitr_1.9       
## [13] magrittr_1.5     munsell_0.4.2    parallel_3.1.2   plyr_1.8.1      
## [17] proto_0.3-10     rmarkdown_0.3.10 scales_0.2.4     stringr_0.6.2   
## [21] tools_3.1.2      yaml_2.1.13
```
