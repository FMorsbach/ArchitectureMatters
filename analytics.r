library(readr)
library(ggplot2)
library(ggthemes)

data <- read_csv("results.csv", col_types = cols(model = col_integer(), bs = col_integer(), epochs = col_integer(), nmul = col_double(), nmicro = col_integer(), l2 = col_double(), eps = col_double()))

data$model <- data$model + 1
data$model = as.factor(data$model)
data$lr = as.factor(data$lr)
data$l2 = as.factor(data$l2)
data$bs = as.factor(data$bs)
data$nmul = as.factor(data$nmul)
data$nmicro = as.factor(data$nmicro)
data <- subset(data, dp == TRUE)

ggplot(data, aes(y=val_acc, x=epochs, col=model)) +
  geom_smooth(se = FALSE, aes(linetype=nmul), size = 1.0) +
  theme_clean() +
  theme(
    legend.position = "top",
    legend.direction = "horizontal", 
    legend.box = "horizontal",
    legend.text = element_text(size=13),
    legend.title = element_text(size=13),
    axis.title=element_text(size=13,face="bold")
  )+
  xlab("Epochs") +
  ylab("Validation Accuracy") +
  labs(linetype = "Noise multiplier") + 
  labs(color = "Architecture")

ggsave("graph.png", width = 225, height = 120, units = "mm", dpi = 1000)
