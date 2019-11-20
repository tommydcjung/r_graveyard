library(ggplot2)
library(dplyr)
data <- read.csv(file="~/dev/vcache/memtest16-2.csv", sep=",")
data$KB <- data$N/1024*4
data$cache <- factor(data$cache, levels=c("blocking", "non-blocking-8", "non-blocking-16", "non-blocking-32"))

q1 <- ggplot(data, aes(x=factor(KB),y=speedup,fill=cache)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(x="data size (KB)", y="speedup") +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=17),
        axis.title.y=element_text(size=17))
  
q1

ggsave("~/dev/vcache/speedup.png", width = 8.11*1.5, height = 5.82*1.5)

q2 <- ggplot(filter(data, KB>=256), aes(x=factor(KB),y=dma_read_req_reduction,fill=cache)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(x="data size (KB)", y="reduction in DMA read request") +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=17),
        axis.title.y=element_text(size=17))

q2
ggsave("~/dev/vcache/dma_read_req.png", width = 8.11*1.5, height = 5.82*1.5)


q3 <- ggplot(filter(data, KB>=256), aes(x=factor(KB),y=dma_write_req_reduction,fill=cache)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(x="data size (KB)", y="reduction in DMA write request") +
  theme_minimal() +
  theme(axis.line.x=element_line(color="black"),
        axis.line.y=element_line(color="black"),
        panel.background=element_rect(fill="#ffffff"),
        panel.grid.major=element_line(size=0.1,linetype='solid',colour="#dddddd"), 
        panel.grid.minor=element_line(size=0.1,linetype='solid',colour="#dddddd"),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=17),
        axis.title.y=element_text(size=17))

q3
ggsave("~/dev/vcache/dma_write_req.png", width = 8.11*1.5, height = 5.82*1.5)