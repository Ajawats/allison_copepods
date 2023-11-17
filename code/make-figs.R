library(scales)
library(ggtext)

source('code/get-data.R')


# DEFINE SCALES AND NAMES -------------------------------------------------

shps = c("LSZ2"=0, "SJR1"=1, "SJR2"=2, "WLD2"=4, "YBP1"=5, "YBP2" = 6)
lbls = c("CenDiaLg"="Centric diatoms Large",
         "CenDiaSm"="Centric diatoms Small",
         "CilLg"="Ciliates Large",
         "CilSm"="Ciliates Small",
         "FlagSm"="Flagellates Small",
         "Other" = "Other")



# FUNCTION TO MAKE FIGS ---------------------------------------------------

copepodPlot <- function(df, df2, ylab, fname, logscale = TRUE){
  p <- ggplot() +
    geom_point(data = df, aes(x = taxaGroup, y = value, color = taxaGroup, shape = event, group = event), position = position_dodge(width = 0.5)) +
      geom_point(data = df2, aes(x = taxaGroup, y = avg, shape = event, group = event), size = 3, position = position_dodge(width = 0.5), show.legend = FALSE) +
    scale_shape_manual(values = shps, name = "Event") +
    scale_x_discrete(labels = str_wrap(lbls, width = 1)) +
    labs(x = "Taxa Group",
         y = ylab) +
    guides(color = FALSE) +
    theme_classic() +
    theme(axis.title.y = element_markdown(), legend.title.align = 0.5)
  
  if(logscale) {
    p + scale_y_log10(labels = label_number())
  }
  
  ggsave(filename = fname, path = "figs/", scale = 2)
}


# MAKE AND SAVE FIGS ------------------------------------------------------

ingYLab <- "Ingestion Rate \u03bc C copepod<sup>-1</sup> day<sup>-1</sup>"
clrYLab <- "Clearance Rate \u03bc C copepod<sup>-1</sup> day<sup>-1</sup>"

copepodPlot(ingDat, ingMeans, ingYLab, "ingestion_logscale.jpg")
copepodPlot(ingDat, ingMeans, ingYLab, "ingestion.jpg", logscale = FALSE)
copepodPlot(clrDat, clrMeans, clrYLab, "clearance.jpg", logscale = FALSE)
