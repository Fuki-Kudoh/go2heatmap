### Usage
```r
csv_uri <- "path/to/your/tpm_matrix.csv"
tpm_data <- read.csv(csv_uri, header = TRUE, check.names = FALSE)
go_accession <- "GO:0008150"
go2heatmap(csv_uri, go_accession)
```
