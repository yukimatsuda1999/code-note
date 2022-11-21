if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("fgsea")
library(fgsea)

sample = read_tsv("topGO/sample.tsv")
mapped_genes = sample$`HGNC symbol` %>% unique()
scores = runif(length(mapped_genes), 0, 1)
named_scores = setNames(scores, mapped_genes)

kegg_pathways = gmtPathways("GSEA/c2.cp.kegg.v2022.1.Hs.symbols.gmt")

fgseaRes <- fgsea(
  pathways = kegg_pathways, 
  stats    = named_scores,
  minSize  = 1,  # 15
  maxSize  = length(named_scores)-1,  # 500
  scoreType = "pos"  # c("std", "pos", "neg")
  )  

head(fgseaRes[order(pval), ])


