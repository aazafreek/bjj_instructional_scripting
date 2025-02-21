#!/bin/bash
set -x
log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

log_error() {
	echo -e "\e[31m[ERROR]\e[0m $1"
}

video_dir=$1
output_dir=$2

video_files=$(ls $video_dir | grep '.mp4')
cd $video_dir
file_names=""
for file in $video_files; do
	file_name=$( echo $file | cut -d'.' -f1 )
	if [ ! -f "$output_dir/$file_name.srt" ] && [ ! -f "$video_dir/$file_name.srt" ]; then
		file_names="$file_name $file_names"
	fi
done

unset $0

for file in $file_names; do
	npx gen-subs for $file.mp4 && echo -e  "\e[32m[INFO]\e[0m Created subtitles for $file."
done
# echo $srt_files | xargs -n 1 -P 4 bash -c 'npx gen-subs for "$0" &> $0.log && echo -e "\e[32m[INFO]\e[0m Created subtitles for $0."'

for file in $file_names; do
	file_name=$( echo $file | cut -d'.' -f1 )
	if [ ! -f "$output_dir/$file_name.srt" ] && [ ! -f "$video_dir/$file_name.srt" ]; then
		log_error "ERROR: Enable to create subtitles for $file_name"
	fi
done

mv $video_dir/*.srt $output_dir 2> /dev/null
mv $video_dir/*.log $output_dir 2> /dev/null
