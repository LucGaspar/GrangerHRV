data = read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/5.csv")
data = data.frame(data$RR_E, data$RR_F)
var.2c <- VAR(data, p = 5, type = 'const')
causality(var.2c, cause = 'data.RR_E')$Granger
causality(var.2c, cause = 'data.RR_F')$Granger



VAR <- function(x, p=1) {

    T <- dim(x)[1]
    K <- dim(x)[2]

    for (k in 1:K) {
		x[,k] <- (x[,k] - mean(x[,k])) / sd(x[,k])
    }

    Y <- x[(1+p):T, ]

    pp <- 1

    Z <- x[(p-pp+1):(T-p+p-pp), ]
    if (p > 1) {
        for (pp in 2:p) {
            Z <- cbind(Z, x[(p-pp+1):(T-p+p-pp), ])
        }
    }

    Y <- t(Y)
    Z <- t(Z)
    B <- Y%*%t(Z)%*%qr.solve(Z%*%t(Z))
    u <- Y - B %*% Z

    pvalue <- matrix(0, K, K)
    for (target in 1:K) {
        Sigma <- (t(u[target,])%*%u[target,]) / (ncol(Z) - nrow(Z))

        for (source in 1:K) {
            C <- matrix(0, p, ncol(B))
            jj <- source

            for (pp in 1:p) {
                C[pp,jj] <- 1
                jj <- jj + K
            }

            BB <- B[target,]
            wald <- t(C %*% BB) %*% qr.solve(C %*% qr.solve(Z %*% t(Z)) %*% t(C)) %*% (C %*% BB) / Sigma
            pvalue[source, target] <- 1-pchisq(wald, df=nrow(C))
        }
    }

    Sigma <- (t(u) %*% u) / (ncol(Z) - nrow(Z))

    res <- list()
    res$ar <- array(0, c(p, K, K))

    j <- 1
    for (r in 1:p) {
        res$ar[r,,] <- B[1:K, j:(j+K-1)]
        j <- j + K
    }

    res$aic <- log(det((u %*% t(u))),exp(1)) + (2*(K^2)*p) / T
    res$p.value <- pvalue
    res$coef <- B
    res$order <- p
    res$var.pred <- Sigma

    return(res)
}

library(dplyr)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/1.csv")
dt <- select(data, RR_A, RR_B, Pos_B)

res <- VAR(dt)
res2 <- VAR(dt, p =2)
res3 <- VAR(dt, p = 3)
res4 <- VAR(dt, p=4)
res5 <- VAR(dt, p=5)
res$p.value
res2$p.value
res3$p.value
res4$p.value
res5$p.value




res$coef
res$order