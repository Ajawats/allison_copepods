### Plot IR ONLY YBP2 large ciliates, SJR1 LSZ2 large centric diatoms
library(scales)
library(ggtext)
library(RColorBrewer)

source('code/get-data.R')
source('wimGraph-and-Palettes.R')


# DEFINE SCALES AND NAMES -------------------------------------------------

shps = c("LSZ2"=0, "SJR1"=1, "YBP2" = 6)
lbls = c("CenDiaLg"="Large centric diatoms ",
         "CilLg"="Large ciliates")

# FUNCTION TO MAKE FIGS ---------------------------------------------------

copepodPlot <- function(reps, means, ylab, plotname, filename, logscale = TRUE){
  p <- ggplot() +
    geom_point(data = reps, aes(x = taxaGroup, y = value, color = taxaGroup, 
                                shape = event, group = event), size = 2.5, stroke = 1.0,
               position = position_dodge(width = 0.5)) +
    geom_point(data = means, aes(x = taxaGroup, y = avg, shape = event, group = event), 
               size = 5, position = position_dodge(width = 0.5), stroke = 1.2, show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Sampling Location") +
    scale_color_manual(values = c("#1b9e77", "#7570b3")) +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
    scale_y_continuous(breaks = seq(0,6, by =1))+
    labs(x = NULL,
         y = NULL) +
    guides(color = FALSE) +
    wimGraph()+
    theme(legend.position = "none",
          axis.text.x = element_text(size = 14))
  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  } else {
    p
  }
  
  #ggsave(filename = filename, path = "figs/", scale = 2, width = 5, units = "in")
}


# MAKE AND SAVE FIGS ------------------------------------------------------

ingYLab <- "\u03bcg C copepod<sup>-1</sup> day<sup>-1</sup>"

copepodPlot(ingDatv3, ingMeans_v3, ingYLab, "Ingestion Rate", "ingestion.jpg", logscale = FALSE)



