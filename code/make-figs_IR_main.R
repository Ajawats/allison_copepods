### Plot IR no YBP2 large ciliates, SJR1 LSZ2 large centric diatoms
##  Remove x and y axis titles and 
library(scales)
library(ggtext)
library(RColorBrewer)

source('code/get-data.R')
source('wimGraph-and-Palettes.R')


# DEFINE SCALES AND NAMES -------------------------------------------------

shps = c("LSZ2"=0, "SJR1"=1, "SJR2"=5, "WLD2"=4, "YBP1"=2, "YBP2" = 6)
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
                                shape = event, group = event), size = 2.5, stroke = 1.0, 
               position = position_dodge(width = 0.5)) +
    geom_point(data = means, aes(x = taxaGroup, y = avg, shape = event, group = event), 
               size = 5, position = position_dodge(width = 0.5), stroke = 1.2, show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Sampling Event") +
    scale_color_brewer(palette = "Dark2") +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
    labs(x = NULL,
         y = ylab) +
    guides(color = FALSE) +
    wimGraph() +
    theme(axis.title.y = element_markdown(size = 14), 
          axis.text.x = element_text(size = 14),
          legend.title.align =  0.5, 
          legend.justification = "bottom", 
          legend.text = element_text(size =12),
          legend.title = element_text(size=14),
          plot.title = element_text(hjust=0.5))
  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  } else {
    p
  }
  
  #ggsave(filename = filename, path = "figs/", scale = 2, width = 5, units = "in")
}



# MAKE AND SAVE FIGS ------------------------------------------------------

#ingYLab <- "\u03bcg C copepod<sup>-1</sup> day<sup>-1</sup>"

copepodPlot(ingDatv2, ingMeans_v2, ingYLab, "Ingestion Rate", "ingestionV2.jpg", logscale = FALSE)



