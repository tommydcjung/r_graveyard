library(ggplot2)
library(dplyr)
data <- read.csv(file="~/dev/vcache/memtest16.csv", sep=",")
data$KB <- data$N/1024*4
data <- filter(data, KB >=256)


q <- ggplot(data, aes(x=KB,y=num_cycle,color=cache,shape=cache)) +
  geom_point(size=1.5,alpha=1) +
  geom_line(size=0.4,alpha=0.8) +
  labs(x="data size (KB)", y="# of cycles") +
  scale_x_continuous(trans="log2",
                     breaks=c(16, 32, 64, 128, 256, 512, 1024),
                     label=c("16", "32", "64", "128", "256", "512", "1024")) +
  scale_y_continuous(trans="log2",
                     breaks=c(10^3, 10^4, 10^5),
                     label=c("10^3", "10^4", "10^5")) +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"))

q <- ggplot(data, aes(x=KB,y=dma_write_req,shape=cache, color=cache)) +
  geom_point(size=1.5,alpha=1) +
  geom_line(size=0.4,alpha=0.8) +
  scale_x_continuous(trans="log2",
                     breaks=c(256, 512, 1024),
                     label=c("256", "512", "1024")) +
  scale_y_continuous(trans="log10") +
  labs(x="data size (KB)", y="# of DRAM Read Requests") +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"))
q
