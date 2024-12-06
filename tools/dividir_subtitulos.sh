#!/bin/bash

for file in $( ls *.srt ); do
	num_chars=$( wc -m $file | cut -d ' ' -f1 )
	if (( $num_chars > 128000 )) ; then
		echo "IN"
		split -b 128k $file $file
	fi
done
