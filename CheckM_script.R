# R Script for visualsing data from CheckM

# Install function for packages

packages<-function(x){
  x<-as.character(match.call()[[2]])
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x,repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}
packages(tidyverse)
packages(ggpubr)

# Finds the CheckM output file

file = dir()[grep('.txt', dir())]

# Import CheckM dataset

checkm_data = read_delim(file, delim = '\t', col_names = T)

#1 Create density plot for genome size

genome_size_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`Genome size (bp)` / 1000000)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "Genome size (Mbp)", y = "Density") +
    theme_classic()

no_label_genome_size_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`Genome size (bp)` / 1000000)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "Genome size (Mbp)", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

#2 Create density plot for number of contigs

contig_number_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`# contigs`)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "Number of contigs", y = "Density") +
      theme_classic()

no_label_contig_number_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`# contigs`)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "Number of contigs", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

#3 Create density plot for N50

N50_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`N50 (contigs)` / 1000)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "N50 (Kbp)", y = "Density") +
      theme_classic()

no_label_N50_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`N50 (contigs)` / 1000)) +
  geom_density(color = "black", size = 1, fill = "#bf1744") +
    labs(x = "N50 (Kbp)", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

#4 Create density plot for completeness

completeness_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$Completeness)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Completeness (%)", y = "Density") +
      theme_classic()

no_label_completeness_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$Completeness)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Completeness (%)", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

#5 Create density plot for contamination

contamination_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$Contamination)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Contamination (%)", y = "Density") +
      theme_classic()

no_label_contamination_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$Contamination)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Contamination (%)", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

#6 Create density plot for strain heterogeneity

strain_heterogeneity_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`Strain heterogeneity`)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Strain heterogeneity", y = "Density") +
      theme_classic()

no_label_strain_heterogeneity_density_plot = ggplot(data = checkm_data, mapping = aes(x = checkm_data$`Strain heterogeneity`)) +
  geom_density(color = "black", size = 0.5, fill = "#bf1744") +
    labs(x = "Strain heterogeneity", y = "Density") +
      theme_classic() +
        theme(axis.title.y = element_blank())

# Use ggpubr to aggregate all plots

density_plots = ggarrange(no_label_genome_size_density_plot, no_label_contig_number_density_plot, no_label_N50_density_plot, 
  no_label_completeness_density_plot, no_label_contamination_density_plot, no_label_strain_heterogeneity_density_plot,
      ncol = 2, nrow = 3, align = "hv")

# Annotate the aggregated plots so you don't have 'density' repeated for each y-axis

annotated_density_plots = annotate_figure(density_plots, left = text_grob("Density", rot = 90))

# Print plots to pdf

pdf("Genome size plot.pdf")
print(genome_size_density_plot)
dev.off()

pdf("Contig number plot.pdf")
print(contig_number_density_plot)
dev.off()

pdf("N50 plot.pdf")
print(N50_density_plot)
dev.off()

pdf("Completeness plot.pdf")
print(completeness_density_plot)
dev.off()

pdf("Contamination plot.pdf")
print(contamination_density_plot)
dev.off()

pdf("Strain heterogeneity.pdf")
print(strain_heterogeneity_density_plot)
dev.off()

pdf("All plots.pdf")
print(annotated_density_plots)
dev.off()
