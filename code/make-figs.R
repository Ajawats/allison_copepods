source('code/get-data.R')

copepodPlot <- function(x, avg, name){
  
  ggplot() +
    geom_point(data = x, aes(x = taxaGroup, y = value)) +
    geom_point(data = avg, aes(x = taxaGroup, y = avg), color = 'red') +
    facet_wrap(~event, scales = "free") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
  
  ggsave(filename = name, path = "figs/", scale = 5)
}


copepodPlot(ingDat, ingMeans, "ingestion.jpg")
copepodPlot(clrDat, clrMeans, "clearance.jpg")
