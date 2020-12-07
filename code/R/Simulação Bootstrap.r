library(boot)

T <- 1000
t = 1
X <- vector(length = T)
Y <- vector(length = T)
X[0] <- rnorm(0)
Y[0] <- rnorm(0)
while (t < T) {
    t = t + 1
    Y[t] <- 0.5*Y[t-1] + rnorm(1)
    X[t] <- 0.5*X[t-1] + rnorm(1)  
}

xy <- data.frame(data$X, data$Y)

n = T
Brep = 10000

X <- vector(length = T)
Y <- vector(length = T)
T = 1000
nboot = 1000
p_valores = array(0, nboot)
for(boot in 1:nboot) {
	t = 1
	X[0] <- rnorm(0)
	Y[0] <- rnorm(0)
	while (t < T) {
		t = t + 1
		Y[t] <- 0.5*Y[t-1] + rnorm(1)
		X[t] <- 0.5*X[t-1] + rnorm(1)  
	}


	rr <- correlations(X, Y)
	p_valores[boot] <- rr$p



}

# Bootstrap the Pearson correlation coefficient

pearson <- function(d,i=c(1:n)){
        d2 <- d[i,]
        return(cor(d2$X,d2$Y))
     }
bootcorr <- boot(data=data,statistic=pearson,R=Brep)



correlations <- function(x, y, block=10, nboot=1000) {

	orig <- cor(x,y)
	distr <- array(0, nboot)

	for(boot in 1:nboot) {

		nblock <- length(x)/block

		tmpx <- sample(seq(1:(length(x)-block)), size=nblock, replace=TRUE)
		tmpy <- sample(seq(1:(length(y)-block)), size=nblock, replace=TRUE)

		x.b <- 0
		y.b <- 0

		for(i in 1:nblock) {
			x.b <- c(x.b, x[tmpx[i]:(tmpx[i]+block-1)])
			y.b <- c(y.b, y[tmpy[i]:(tmpy[i]+block-1)])
		}
		distr[boot] <- cor(x.b, y.b)
	}

	p <- length(which(abs(distr) >= abs(orig)))/nboot

    my_return <- list('p' = p, 'distr' = distr)

	return (my_return)
}

X <- vector(length = T)
Y <- vector(length = T)
T = 1000
nboot = 1000
p_valores = array(0, nboot)
for(boot in 1:nboot) {
	t = 1
	X[0] <- rnorm(0)
	Y[0] <- rnorm(0)
	while (t < T) {
		t = t + 1
		Y[t] <- 0.5*Y[t-1] + rnorm(1)
		X[t] <- 0.5*X[t-1] + rnorm(1)  
	}
	rr <- correlations(X, Y)
	p_valores[boot] <- rr$p
}

hist(p_valores)