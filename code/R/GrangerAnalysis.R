data = read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Time Series/Data/100/ToR/Category/5.csv")
data = data.frame(data$Pulse.E, data$Pulse.F)
var.2c <- VAR(data, p = 15, type = 'const')
causality(var.2c, cause = 'data.Pulse.E')$Granger
causality(var.2c, cause = 'data.Pulse.F')$Granger

data = read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Time Series/Data/100/ToR/Category/5.csv")
data = data.frame(data$PosE, data$PosF)
var.2c <- VAR(data, p = 15, type = 'const')
causality(var.2c, cause = 'data.PosE')$Granger
causality(var.2c, cause = 'data.PosF')$Granger

data = read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Time Series/Data/100/ToR/Category/5.csv")
data = data.frame(data$Pulse.E, data$Pulse.F, data$PosF)
var.2c <- VAR(data, p = 15, type = 'const')
causality(var.2c, cause = c('data.Pulse.F', 'data.PosF'))$Granger

data = read.csv("C:/Users/LucasMarquesGasparin/Desktop/Learning/TCC/Time Series/Data/100/ToR/Category/5.csv")
data = data.frame(data$Pulse.F, data$Pulse.E, data$PosE)
var.2c <- VAR(data, p = 15, type = 'const')
var.2c
causality(var.2c, cause = c('data.Pulse.B', 'data.PosB'))$Granger



