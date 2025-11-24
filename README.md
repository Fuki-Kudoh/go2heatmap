**Overview**

`go2heatmap` is a small R utility for generating heatmaps of gene expression (TPM/RPKM counts) for genes annotated to a specific Gene Ontology (GO) term. It reads a CSV expression matrix (genes × samples), filters genes by a GO accession, and produces a heatmap suitable for quick exploration and figures.

**Installation**

- **CRAN / Bioconductor**: If packaged, install via `install.packages()` or Bioconductor instructions.
- **From source / development**: Use `devtools::install_local()` or `devtools::install_github("your/repo")` if available.

Example (if using `devtools`):

```r
# install.packages("devtools")
devtools::install_github("Fuki-Kudoh/go2heatmap")
```

**Input format**

- The input is a CSV file where rows are genes and columns are samples.
- The first column should contain gene identifiers (e.g., gene symbols or Ensembl IDs) and must be unique.
- Remaining columns are numeric expression values (TPM, RPKM or normalized counts).
- CSV must include a header row. Example header: `gene,SampleA,SampleB,SampleC`

**Function: go2heatmap**

Usage:

```r
go2heatmap(csv_path, go_accession, gene_col = 1, output_file = NULL, scale = TRUE, ...)
```

- **`csv_path`**: Path to the CSV expression matrix.
- **`go_accession`**: GO term accession string (e.g., `"GO:0008150"`).
- **`gene_col`**: Column index or name that contains gene IDs (default `1`).
- **`output_file`**: Optional path to save the heatmap image (PNG/PDF). If `NULL`, the plot is shown in the active device.
- **`scale`**: Logical; if `TRUE`, scale rows (genes) for better visualization.
- Additional arguments (`...`) may be passed to underlying plotting or clustering methods.

**Basic example**

```r
csv_uri <- "path/to/your/tpm_matrix.csv"
tpm_data <- read.csv(csv_uri, header = TRUE, check.names = FALSE)
go_accession <- "GO:0008150"

# Basic call reading from file path
go2heatmap(csv_uri, go_accession)

# Or call with preloaded data frame if the function supports it
# go2heatmap(tpm_data, go_accession, gene_col = "gene")
```

**Expected output**

- A clustered heatmap showing expression of genes annotated to the supplied GO term across samples.
- If `output_file` is provided, the heatmap will be saved to disk (recommended for reports/figures).

**Tips & Troubleshooting**

- If no genes are returned for a GO term, confirm that your gene identifiers match the annotation source used by the package.
- For very large gene sets consider subsetting by variance or applying a threshold to improve readability.
- Use `scale = TRUE` to make per-gene patterns more visible when genes have different dynamic ranges.

**Example workflow**

1. Prepare expression matrix with consistent gene IDs.
2. Choose GO accession(s) of interest.
3. Run `go2heatmap()` for each GO term and inspect or save the resulting plots.

**Contributing**

Contributions, bug reports, and feature requests are welcome. Please open an issue or submit a pull request on GitHub.

**License**

Include your project's license here (e.g., MIT, GPL-3).

**Contact**

Maintainer: `Fuki-Kudoh` (or add email/contact details).

**Example script**

- `examples/generate_example_heatmap.R`: A small R script that demonstrates how to read an expression matrix and produce a heatmap using `pheatmap`. The script is intended as a usage example for users who supply their own expression CSV.

To run the example script (point it at your own data):

```bash
# from the repository root
Rscript examples/generate_example_heatmap.R
```

If `pheatmap` is missing the script will attempt to install it from CRAN.

