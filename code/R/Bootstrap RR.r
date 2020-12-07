correlations <- function(x, y, block=5, nboot=1000) {

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

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/1.csv")

rr1  <- correlations(data$RR_A,data$RR_B)
pos1 <- correlations(data$Pos_A,data$Pos_B)
del1 <- correlations(data$Delta_PosA, data$Delta_PosB)

rp1 <-correlations(data$RR_A,data$Pos_A)
rd1 <-correlations(data$RR_A,data$Delta_PosA)
rp1_ <-correlations(data$RR_B,data$Pos_B)
rd1_ <-correlations(data$RR_B,data$Delta_PosB)
crp1 <-correlations(data$RR_A,data$Pos_B)
crd1 <-correlations(data$RR_A,data$Delta_PosB)
crp1_ <-correlations(data$RR_B,data$Pos_A)
crd1_ <-correlations(data$RR_B,data$Delta_PosA)

crd1$p
crd2$p
crd3$p
crd4$p
crd5$p
crd6$p


data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/2.csv")

rr2  <- correlations(data$RR_A,data$RR_B)
pos2 <- correlations(data$Pos_A,data$Pos_B)
del2 <- correlations(data$Delta_PosA, data$Delta_PosB)

rp2 <-correlations(data$RR_A,data$Pos_A)
rd2 <-correlations(data$RR_A,data$Delta_PosA)
rp2_ <-correlations(data$RR_B,data$Pos_B)
rd2_ <-correlations(data$RR_B,data$Delta_PosB)

crp2 <-correlations(data$RR_A,data$Pos_B)
crd2 <-correlations(data$RR_A,data$Delta_PosB)
crp2_ <-correlations(data$RR_B,data$Pos_A)
crd2_ <-correlations(data$RR_B,data$Delta_PosA)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/3.csv")

rr3  <- correlations(data$RR_C,data$RR_D)
pos3 <- correlations(data$Pos_C,data$Pos_D)
del3 <- correlations(data$Delta_PosC, data$Delta_PosD)

rp3 <-correlations(data$RR_C,data$Pos_C)
rd3 <-correlations(data$RR_C,data$Delta_PosC)
rp3_ <-correlations(data$RR_D,data$Pos_D)
rd3_ <-correlations(data$RR_D,data$Delta_PosD)
crp3 <-correlations(data$RR_C,data$Pos_D)
crd3 <-correlations(data$RR_C,data$Delta_PosD)
crp3_ <-correlations(data$RR_D,data$Pos_C)
crd3_ <-correlations(data$RR_D,data$Delta_PosC)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/4.csv")

rr4  <- correlations(data$RR_C,data$RR_D)
pos4 <- correlations(data$Pos_C,data$Pos_D)
del4 <- correlations(data$Delta_PosC, data$Delta_PosD)

rp4 <-correlations(data$RR_C,data$Pos_C)
rd4 <-correlations(data$RR_C,data$Delta_PosC)
rp4_ <-correlations(data$RR_D,data$Pos_D)
rd4_ <-correlations(data$RR_D,data$Delta_PosD)

crp4 <-correlations(data$RR_C,data$Pos_D)
crd4 <-correlations(data$RR_C,data$Delta_PosD)
crp4_ <-correlations(data$RR_D,data$Pos_C)
crd4_ <-correlations(data$RR_D,data$Delta_PosC)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/5.csv")

rr5  <- correlations(data$RR_E,data$RR_F)
pos5 <- correlations(data$Pos_E,data$Pos_F)
del5 <- correlations(data$Delta_PosE, data$Delta_PosF)

rp5 <-correlations(data$RR_E,data$Pos_E)
rd5 <-correlations(data$RR_E,data$Delta_PosE)
rp5_ <-correlations(data$RR_F,data$Pos_F)
rd5_ <-correlations(data$RR_F,data$Delta_PosF)

crp5 <-correlations(data$RR_E,data$Pos_F)
crd5 <-correlations(data$RR_E,data$Delta_PosF)
crp5_ <-correlations(data$RR_F,data$Pos_E)
crd5_ <-correlations(data$RR_F,data$Delta_PosE)

data <- read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Data/Processed/6.csv")

rr6  <- correlations(data$RR_E,data$RR_F)
pos6 <- correlations(data$Pos_E,data$Pos_F)
del6 <- correlations(data$Delta_PosE, data$Delta_PosF)

rp6 <-correlations(data$RR_E,data$Pos_E)
rd6 <-correlations(data$RR_E,data$Delta_PosE)
rp6_ <-correlations(data$RR_F,data$Pos_F)
rd6_ <-correlations(data$RR_F,data$Delta_PosF)

crp6 <-correlations(data$RR_E,data$Pos_F)
crd6 <-correlations(data$RR_E,data$Delta_PosF)
crp6_ <-correlations(data$RR_F,data$Pos_E)
crd6_ <-correlations(data$RR_F,data$Delta_PosE)


rr1$p
hist(rr1$distr)

pos1$p
hist(pos1$distr)

del1$p
hist(del1$distr)


# Simulação

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