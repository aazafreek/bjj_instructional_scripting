#!/bin/bash

log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

log_error() {
	echo -e "\e[31m[ERROR]\e[0m $1"
}

video_dir=$1
data_dir=$2

video_files=$(ls $video_dir | grep '.mp4')
cd $video_dir
srt_files=""
for file in $video_files; do
	file_name=$( echo $file | cut -d'.' -f1 )
	if [ ! -f "$data_dir/$file_name.srt" ] && [ ! -f "$video_dir/$file_name.srt" ]; then
		srt_files="$file $srt_files"
	fi
done

unset $0

for file in $srt_files; do
	npx gen-subs for $file &> $file.log && echo -e  "\e[32m[INFO]\e[0m Created subtitles for $file."
# echo $srt_files | xargs -n 1 -P 4 bash -c 'npx gen-subs for "$0" &> $0.log && echo -e "\e[32m[INFO]\e[0m Created subtitles for $0."'

# Comprobamos los archivos que no se han podido crear
for file in $srt_files; do
	file_name=$( echo $file | cut -d'.' -f1 )
	if [ ! -f "$data_dir/$file_name.srt" ] && [ ! -f "$video_dir/$file_name.srt" ]; then
		log_error "ERROR: Enable to create subtitles for $file_name"
	fi
done

# Movemos los archivos a la carpeta de datos
mv $video_dir/*.srt $data_dir 2> /dev/null
mv $video_dir/*.log $data_dir 2> /dev/null
