### Plot Abundance ONLY YBP2 large ciliates and other organisms
library(scales)
library(ggtext)
library(RColorBrewer)

source('code/get-data.R')
source('wimGraph-and-Palettes.R')


# DEFINE SCALES AND NAMES -------------------------------------------------

shps = c("YBP2" = 6)
lbls = c("CilLg"="Large ciliates",
         "Other"="Other organisms")

# FUNCTION TO MAKE FIGS ---------------------------------------------------

copepodPlot <- function(reps, means, ylab, plotname, filename, logscale = TRUE){
  p <- ggplot() +
    geom_point(data = reps, aes(x = taxaGroup, y = value, color = taxaGroup, 
                                shape = event, group = event), size = 2.5, stroke = 1.0,
               position = position_dodge(width = 0.5)) +
    geom_point(data = means, aes(x = taxaGroup, y = avg, shape = event, group = event), 
               size = 5, position = position_dodge(width = 0.5), stroke = 1.2, show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Sampling Location") +
    scale_color_manual(values = c("#7570b3", "#e6ab02")) +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
    scale_y_continuous(breaks = seq(30,90, by =10))+
    labs(x = NULL,
         y = NULL) +
    guides(color = FALSE) +
    wimGraph()+
    theme(legend.position = "none")
  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  } else {
    p
  }
  
  #ggsave(filename = filename, path = "figs/", scale = 2, width = 5, units = "in")
}


# MAKE AND SAVE FIGS ------------------------------------------------------

copepodPlot(abunDatv3, abunMeansOnlyBig, logscale = FALSE)



