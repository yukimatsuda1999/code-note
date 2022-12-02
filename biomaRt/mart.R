BiocManager::install("biomaRt")
library(biomaRt)

ensembl <- useEnsembl(biomart = "genes")

fg = read_csv("topGO/ggallus/interested.csv") %>% drop_na()
goids = getBM(attributes = c('entrezgene_id', 'go_id'), 
              filters = 'entrezgene_id', 
              values = fg$Entrez, 
              mart = ensembl)
