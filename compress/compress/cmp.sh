#! /bin/zsh


########## File Compression ##########
## .zip
printf "Hello, world\n%.0s" {0..1000} > test.txt
zip test.txt.zip test.txt

## .gz
printf "Hello, world\n%.0s" {0..1000} > test.txt
gzip test.txt

## .bz
printf "Hello, world\n%.0s" {0..1000} > test.txt
bzip2 test.txt

## compare
ls -l test.txt*


########## Directory Compression ##########
mkdir hoge
printf "Hello, world\n%.0s" {0..1000} > hoge/hoge.txt

## tar.gz
tar -zcvf hoge.tar.gz hoge

## tar.bz2
tar -jcvf hoge.tar.bz2 hoge

## compare
ls -l hoge*


<< NOT_RUN

########## File Decompression ##########
unzip test.txt.zip
gunzip test.txt.gz
bunzip2 test.txt.bz2

########## Directory Decompression ##########
tar -xzf hoge.tar.gz
tar -xjf hoge.tar.bz2

NOT_RUN
