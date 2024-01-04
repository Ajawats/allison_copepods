### Make figure for abundance, following make-figs.R
### First is whole data
##  Next is data minus YBP2 lg ciliates and other organisms, because their
##  numbers are so high and they need an inset
##  Data with only YBP2 lg ciliates and other organisms is in a separate script
##  make-figs_6.R because it requires no legend, and manually choosing colors so
##  they correspond with the correct colors on the whole plot.

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

# Whole data
copepodPlot <- function(reps, means, ylab, plotname, filename, logscale = TRUE){
  p <- ggplot() +
    geom_point(data = reps, aes(x = taxaGroup, y = value, color = taxaGroup, 
                                shape = event, group = event), size = 2.5,
               position = position_dodge(width = 0.5), stroke = 1) +
    geom_point(data = means, aes(x = taxaGroup, y = avg, shape = event, 
                                 group = event), size = 5, position = position_dodge(width = 0.5), 
               stroke = 1.2,
               show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Sampling Event") +
    scale_color_brewer(palette = "Dark2") +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
  labs(y = ylab, ) +
  #labs(x = NULL, y = NULL ) # for plot of only two taxa groups
    guides(color = FALSE) +
    wimGraph() +
    #theme(legend.position = "none") # for the plot of only two taxa groups
    theme(axis.title.y = element_markdown(size = 10), legend.title.align = 0.5,
          legend.justification = "bottom", legend.text = element_text(size =10),
          legend.title = element_text(size = 12),
          plot.title = element_text(hjust=0.5), axis.title.x = element_blank())

  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  } else {
    p
  }
  
  #ggsave(filename = filename, path = "figs/", scale = 2, width = 5, units = "in")
}

# MAKE AND SAVE FIGS ------------------------------------------------------

abunYLab <- "µg C L<sup> -1</sup>"
#copepodPlot(abunDat, abunMeans, abunYLab, "Abundance", "abundance.jpg", logscale = FALSE)
copepodPlot(abunDatv2, abunMeansPartial, abunYLab,"AbundancePartial", 
            "abundancePartial.jpg", logscale = FALSE)
#copepodPlot(abunDatv3, abunMeansOnlyBig, abunYLab,"AbundanceOnlyBig", 
           # "abundanceOnlyBig.jpg", logscale = FALSE)
