#!/bin/bash

# Limpiar subtitulos
data_dir=$1
cd $data_dir
for file in $( ls *.srt ); do
	i=0
	IFS=$'\n'
	for line in $( cat $file ); do
		mod=$(( $i%3 ))
		if (( $mod == 2 )); then
			echo $line >> $file.cln
		fi
		((i++))
	done
	unset IFS
done
