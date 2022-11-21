#! /bin/zsh
# sh awk/awk_ex.sh awk/sample.tsv


echo "##### INCLUDE HEADER #####"
awk '{print $1}' $1 | while read x; do
	echo $x
done

echo "##### IGNORE HEADER #####"

awk 'NR>1{print $2}' $1 | while read x; do
	echo $x
done
