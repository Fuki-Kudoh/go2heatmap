# Load necessary libraries
if (!requireNamespace("gplots", quietly = TRUE)) {
  install.packages("gplots")
}
if (!requireNamespace("biomaRt", quietly = TRUE)) {
  install.packages("biomaRt")
}
library(gplots)
library(biomaRt)

# Function to create a heatmap based on given GO Accession
go2heatmap <- function(tpm_data, go_accession, scale="row", trace = "none",
                       dendrogram = "both", col = bluered(75), Colv = NA,
                       margins = c(5, 10), cexCol = 0.5, cexRow = 0.5) {
  
  # Set row names and fix duplicate row names
  rownames(tpm_data) <- make.names(tpm_data[[1]], unique = TRUE)
  tpm_matrix <- tpm_data[, -1]
  
  # Connect to Ensembl biomart
  ensembl <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
  
  # Retrieve Mus Musculus genes based on GO Accession
  genes <- getBM(attributes = c('external_gene_name', 'ensembl_gene_id'), 
                 filters = 'go', 
                 values = go_accession, 
                 mart = ensembl)
  
  # Create a gene/product list
  gene_list <- genes$external_gene_name
  
  # Initialize an empty temporary matrix
  temp_matrix <- tpm_matrix[0, , drop = FALSE]
  
  # Extract rows from the TPM matrix for each gene in the gene list and add to the temporary matrix
  for (gene in gene_list) {
    matches <- grep(paste0("^", gene, "$"), rownames(tpm_matrix), ignore.case = TRUE, value = TRUE)
    if (length(matches) > 0) {
      for (match in matches) {
        temp_matrix <- rbind(temp_matrix, tpm_matrix[match, , drop = FALSE])
      }
    }
  }
  
  # Convert to numeric matrix
  temp_matrix <- as.matrix(temp_matrix)
  
  # Draw heatmap only if the temporary matrix has rows
  if (nrow(temp_matrix) > 0) {
    heatmap.2(temp_matrix, scale = scale, trace = trace, dendrogram = dendrogram, 
              col = col, margins = margins, main = go_accession, Colv = Colv,
              cexCol = cexCol, cexRow = cexRow)
  } else {
    message("No matching genes found for the given GO accession in the TPM matrix.")
  }
}

# Example usage
# csv_uri <- "path/to/your/tpm_matrix.csv"
# tpm_data <- read.csv(csv_uri, header = TRUE, check.names = FALSE)
# go_accession <- "GO:0008150"
# go2heatmap(csv_uri, go_accession)
