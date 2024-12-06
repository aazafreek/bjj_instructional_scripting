#!/bin/bash

# This script will convert the HTML file to a beautified HTML file.º
log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

html_dir=$1

cd $html_dir
files=$(ls *.html)
unset $0
ls $files | xargs -n 1 -P 4 bash -c 'cat "$0" | fabric -sp beautify_html > "$0".tmp && echo -e "\e[32m[INFO]\e[0m Beautified html of $0."'

for file in $files; do
	mv $file.tmp $file
done
