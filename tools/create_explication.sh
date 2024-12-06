#!/bin/bash

log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

# This script is used to create the explanation subtitle for the cleaned files.

data_dir=$1
explanation_dir=$2
cd $data_dir
for file in $( ls *.cln ); do
	file_name=$( echo $file | cut -d'.' -f1 )
	cat $file | fabric -sp pattern_sub_expl_bjj > "$explanation_dir/$file_name"_explanation.md
	log_info "Processed $file_name subtitle to explanation."
done

# mv *_explanation.md $explanation_dir

