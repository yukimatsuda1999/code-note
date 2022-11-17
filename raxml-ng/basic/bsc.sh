#! /bin/zsh/

raxml-ng --msa Obscn.fa --all --model GTR+G --bs-trees 100 --threads 2

# --msa	<alignment file>
# --all	topology search + bootstrapping
# --model	specify a model
# --bs-trees	number of bootstrapping
# --threads	number of threads
