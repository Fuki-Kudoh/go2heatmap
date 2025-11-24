#!/usr/bin/env Rscript
# generate_example_heatmap.R
# Reads data/example_tpm.csv and writes images/example_heatmap.png and .svg

if (!requireNamespace("pheatmap", quietly = TRUE)) {
  install.packages("pheatmap", repos = "https://cloud.r-project.org")
}

library(pheatmap)

infile <- file.path("data", "example_tpm.csv")
out_png <- file.path("images", "example_heatmap.png")
out_svg <- file.path("images", "example_heatmap.svg")

if (!file.exists(infile)) {
  stop("Example input file not found: ", infile)
}

df <- read.csv(infile, header = TRUE, row.names = 1, check.names = FALSE)
mat <- as.matrix(df)

# Create PNG
png(out_png, width = 800, height = 600)
try(pheatmap(mat, scale = "row", main = "Example GO heatmap"), silent = FALSE)
dev.off()

# Create SVG
svg(out_svg, width = 8, height = 6)
try(pheatmap(mat, scale = "row", main = "Example GO heatmap"), silent = FALSE)
dev.off()

cat("Wrote:", out_png, "and", out_svg, "\n")
