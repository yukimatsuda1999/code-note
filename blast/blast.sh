makeblastdb -in ${seq_id}.pep.fa -out ${seq_id}.pep.fa -dbtype prot -hash_index
blastp -outfmt "7 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" -evalue 1e-4 -db ${seq_id}.pep.fa -query ${seq_id}.pep.fa -out ${seq_id}.blastp

################
### outfmt  ####
################
# 6: tabular
# 7: tabular with comment lines
# 10: csv

################
### columns  ###
################
# qseqid: Query Seq-id
# qgi: Query GI
# qacc: Query accesion
# sseqid: Subject Seq-id
# sallseqid: All subject Seq-id(s), separated by a ‘;’
# sgi: Subject GI
# sallgi: All subject GIs
# sacc: Subject accession
# sallacc: All subject accessions
# qstart: Start of alignment in query
# qend: End of alignment in query
# sstart: Start of alignment in subject
# send: End of alignment in subject
# qseq: Aligned part of query sequence
# sseq: Aligned part of subject sequence
# evalue: Expect value
# bitscore: Bit score
# score: Raw score
# length: Alignment length
# pident: Percentage of identical matches
# nident: Number of identical matches
# mismatch: Number of mismatches
# positive: Number of positive-scoring matches
# gapopen: Number of gap openings
# gaps: Total number of gap
# ppos: Percentage of positive-scoring matches
# frames: Query and subject frames separated by a ‘/’
# qframe: Query frame
# sframe: Subject frame
# btop: Blast traceback operations (BTOP)
# staxids: unique Subject Taxonomy ID(s), separated by a ‘;’(in numerical order)
# sscinames: unique Subject Scientific Name(s), separated by a ‘;’
# scomnames: unique Subject Common Name(s), separated by a ‘;’
# sblastnames: unique Subject Blast Name(s), separated by a ‘;’ (in alphabetical order)
# sskingdoms: unique Subject Super Kingdom(s), separated by a ‘;’ (in alphabetical order)
# stitle: Subject Title
# salltitles: All Subject Title(s), separated by a ‘<>’
# sstrand: Subject Strand
# qcovs: Query Coverage Per Subject
# qcovhsp: Query Coverage Per HSP
