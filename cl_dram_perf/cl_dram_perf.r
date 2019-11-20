#
#	cl_dram_perf.r
#
#	@author Tommy Jung
#

library(ggplot2)
data <- read.csv(file="./cl_dram_perf.csv", header=FALSE, sep=",")
names(data) <- c("path", "direction", "burst_len", "average", "stdev")
data$average <- ifelse(data$path=="cl", data$average-vled_latency-vdip_latency, data$average)
data$transfer_size <- data$burst_len*64

q <- ggplot(data, aes(x=transfer_size,y=average,color=path,shape=direction)) +
  geom_point(size = 1.2, alpha=1) +
  labs(x="transfer size (KB)", y="latency (ms)") + 
  scale_x_continuous(trans='log2',
                     breaks=c(2^10, 2^15, 2^20, 2^25, 2^30),
                     label=c("1", "32", "1024", "32768", "1048576")) + 
  scale_y_continuous(trans='log10',
                     breaks=c(0.0001, 0.01, 1, 100, 10000),
                     label=c('0.0001', '0.01', '1', '100', '10000')) +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"))

q

ggsave("cl_dram_perf.png", width = 8.11*1.5, height = 5.82*1.5)