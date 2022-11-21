if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("topGO")
BiocManager::install("org.Hs.eg.db")

library(tidyverse)
library(topGO)
library(org.Hs.eg.db)

columns(org.Hs.eg.db)
sample = read_tsv("topGO/sample.tsv")
mapped_genes = sample$`HGNC symbol` %>% unique()
scores = runif(length(mapped_genes), 0, 1)
named_scores = setNames(scores, mapped_genes)


## Make tg_data
tg_data = new(
  "topGOdata",
  ontology="BP",  # "CC", "MF"
  allGenes=named_scores,
  geneSelectionFun=function(x) {x < 0.01},
  # function(x) {logical(length(x))},  # when using ks
  nodeSize=10,
  annotationFun=annFUN.org,
  mapping="org.Hs.eg.db",
  ID="symbol"
  )


## Tests
whichAlgorithms()
whichTests()

resClassicFisher = runTest(tg_data, algorithm="classic", statistic="fisher", sortOrder="increasing")
resElimFisher = runTest(tg_data, algorithm="elim", statistic="fisher", sortOrder="increasing")
resWeightFisher = runTest(tg_data, algorithm="weight", statistic="fisher", sortOrder="increasing")
resClassicKS = runTest(tg_data, algorithm="classic", statistic="ks", sortOrder="increasing")
resElimKS = runTest(tg_data, algorithm="elim", statistic="ks", sortOrder="increasing")
resWeightKS = runTest(tg_data, algorithm="weight01", statistic="ks", sortOrder="increasing")


## Show as table
tg_table = GenTable(
  tg_data,
  elimFisher=resElimFisher,
  topNodes=length(tg_data@graph@nodes) 
  ) %>%
  tibble::as_tibble() %>%
  print()

