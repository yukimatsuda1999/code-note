#! /bin/zsh/

raxml-ng --msa Obscn.fa --evaluate --tree Constrained.nwk --model GTR+G --threads 2

# --evaluate	compute the likelihood of a given fixed tree topology by just optimizing model and/or branch length parameters on that fixed tree
# --tree	tree topology
