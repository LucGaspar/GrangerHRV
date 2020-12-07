library(boot)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/1.csv")
data

bootCorTest <- function(data, i){
    d <- data[i, ]
    cor.test(d$RR_A, d$RR_B)$p.value
}

b <- boot(data, bootCorTest, R = 1000)

b$t0