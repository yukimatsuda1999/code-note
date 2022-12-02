BiocManager::install("topGO")
BiocManager::install("org.Gg.eg.db")

library(tidyverse)
library(topGO)
library(org.Gg.eg.db)


fg = read_csv("topGO/ggallus/interested.csv")
bg = read_csv("topGO/ggallus/background.csv") %>%
  mutate(score = if_else(V1 %in% fg$V1, 1, 0))

scores = bg$score
named_scores = setNames(scores, bg$Entrez)

random_scores = runif(length(bg$Entrez), 0, 1)
named_random_scores = setNames(random_scores, bg$Entrez)

tg_data = new(
  "topGOdata",
  ontology="BP",  # "CC", "MF"
  allGenes=named_scores,
  geneSelectionFun=function(x) {x >= 0.01},
  # function(x) {logical(length(x))},  # when using ks
  nodeSize=1,
  annotationFun=annFUN.org,
  mapping="org.Gg.eg.db",
  ID="ENTREZ"
)

resElimFisher = runTest(tg_data, algorithm="elim", statistic="fisher")
resElimKS = runTest(tg_data, algorithm="elim", statistic="ks", sortOrder="increasing")
