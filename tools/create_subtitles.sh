#!/bin/bash

log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

log_error() {
	echo -e "\e[31m[ERROR]\e[0m $1"
}

video_dir=$1
data_dir=$2

archivos=$(ls $video_dir | grep '.mp4')
cd $video_dir
archivos_sin_srt=""
for archivo in $archivos; do
	nombre_archivo=$( echo $archivo | cut -d'.' -f1 )
	if [ ! -f "$data_dir/$nombre_archivo.srt" ] && [ ! -f "$video_dir/$nombre_archivo.srt" ]; then
		archivo_sin_srt="$archivo $archivo_sin_srt"
	fi
done

unset $0
echo $archivo_sin_srt | xargs -n 1 -P 4 bash -c 'npx gen-subs for "$0" &> $0.log && echo -e "\e[32m[INFO]\e[0m Created subtitles for $0."'

# Comprobamos los archivos que no se han podido crear
for archivo in $archivo_sin_srt; do
	nombre_archivo=$( echo $archivo | cut -d'.' -f1 )
	if [ ! -f "$data_dir/$nombre_archivo.srt" ] && [ ! -f "$video_dir/$nombre_archivo.srt" ]; then
		log_error "ERROR: Enable to create subtitles for $nombre_archivo"
	fi
done

# Movemos los archivos a la carpeta de datos
mv $video_dir/*.srt $data_dir 2> /dev/null
mv $video_dir/*.log $data_dir 2> /dev/null
