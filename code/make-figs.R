library(scales)
library(ggtext)
library(RColorBrewer)

source('code/get-data.R')
source('wimGraph-and-Palettes.R')


# DEFINE SCALES AND NAMES -------------------------------------------------

shps = c("LSZ2"=0, "SJR1"=1, "SJR2"=2, "WLD2"=4, "YBP1"=5, "YBP2" = 6)
lbls = c("CenDiaLg"="Large centric diatoms ",
         "CenDiaSm"="Small centric diatoms",
         "CilLg"="Large ciliates",
         "CilSm"="Small ciliates",
         "FlagSm"="Small Flagellates",
         "Other" = "Other Organisms")

# FUNCTION TO MAKE FIGS ---------------------------------------------------

copepodPlot <- function(reps, means, ylab, plotname, filename, logscale = TRUE){
  p <- ggplot() +
    geom_point(data = reps, aes(x = taxaGroup, y = value, color = taxaGroup, 
                                shape = event, group = event), position = position_dodge(width = 0.9), stroke = 0.5) +
    geom_point(data = means, aes(x = taxaGroup, y = avg, shape = event, 
                                 group = event), size = 3, position = position_dodge(width = 0.5), stroke = 0.8,
                                show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Sampling Event") +
    scale_color_brewer(palette = "Dark2") +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
    labs(y = ylab, ) +
    guides(color = FALSE) +
    wimGraph() +
    theme(axis.title.y = element_markdown(size = 10), legend.title.align = 0.5, 
          plot.title = element_text(hjust=0.5), axis.title.x = element_blank())
  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  } else {
    p
  }
  
  #ggsave(filename = filename, path = "figs/", scale = 2, width = 5, units = "in")
}


# MAKE AND SAVE FIGS ------------------------------------------------------

ingYLab <- "\u03bcg C copepod<sup> -1</sup> day<sup> -1</sup>"
clrYLab <- "mL copepod<sup> -1</sup> day<sup> -1</sup>"

copepodPlot(ingDat, ingMeans, ingYLab, "Ingestion Rate", "ingestion_logscale.jpg")
copepodPlot(ingDat, ingMeans, ingYLab, "Ingestion Rate", "ingestion.jpg", logscale = FALSE)
copepodPlot(clrDat, clrMeans, clrYLab, "Clearance Rate", "clearance.jpg", logscale = FALSE)
