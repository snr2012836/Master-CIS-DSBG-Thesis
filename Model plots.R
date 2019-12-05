## This script assume the use of RStudio, and the containment
## of the script in a directory with the data. Any tempering with the 
## folder may cause error
install.packages("ggplot2")
library(ggplot2)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
country_metrics <- read.csv("Country_metrics.csv")
country_metrics$X <- NULL #fix the default index column 
#%%%%%%%%%%%%% plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
# lets try the bar plot. let us see how accuracy measures per country, 
# with our EU baseline set as a line

g <- ggplot(country_metrics, aes(Country, Model.accuracy)) + geom_bar(stat = "identity") + geom_hline(yintercept = 0.64)

g
# this looks a bit messy with our x labels crowded together. We really cannot see which country is represented by a bar.
# We rename ourfactor levels to ISO 2 codes with the exception of country with more than one sample e.g Germany

levels(country_metrics$Country) #check the levels in order
country_metrics$Country_code <- country_metrics$Country
country_metrics$Country_code <- factor(c("BG","BE","CZ","DK","DE_E","DE_W","EE","GR","ES","FR","GB","HR","IE","IT","CY","LV","LT","LU","HU","MT","NL","NI","PO","PT","RO","SI","SK","FI","SE","AT"))

# redo the plot with country codes

g_accuracy <- ggplot(country_metrics, aes(Country_code, Model.accuracy)) + geom_bar(stat = "identity") + geom_hline(yintercept = 0.64)
g_accuracy 

#lets do the same for recall, precision, and the f1 score

g_recall <- ggplot(country_metrics, aes(Country_code, Model.recall)) + geom_bar(stat = "identity")
g_recall

g_precision <- ggplot(country_metrics, aes(Country_code, Model.precision)) + geom_bar(stat = "identity") + geom_hline(yintercept = 0.64)
g_precision

g_f1_score <- ggplot(country_metrics, aes(Country_code, Model.f1.score)) + geom_bar(stat = "identity") + geom_hline(yintercept = 0.78)
g_f1_score 
