#!/bin/bash

log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

instructional_dir=$1
pwd_instructional_dir=$(pwd)/$instructional_dir
pwd_tools_dir=$(pwd)/tools
actual_pwd=$(pwd)

# Movemos los videos a una carpeta video
log_info "Moving videos to Videos directory"
[ ! -d $instructional_dir/Videos ] && mkdir -p $instructional_dir/Videos
mv $instructional_dir*.mp4 $instructional_dir/Videos 2> /dev/null
cd $instructional_dir/Videos
for file in *; do
	mv -f "$file" `echo $file | tr ' ' '_'` 2> /dev/null
done
cd $actual_pwd
pwd_videos_dir=$(pwd)/"$instructional_dir"Videos

# Creamos una carpeta donde poner la informacion
log_info "Creando data folder"
[ ! -d $instructional_dir/data ] && mkdir -p $instructional_dir/data
pwd_data_dir=$(pwd)/"$instructional_dir"data

# Primero creamos los subtitulos para el video
log_info "Transforming video to srt subtitules"
#$pwd_tools_dir/create_subtitles.sh $pwd_videos_dir $pwd_data_dir
cd $actual_pwd

# Limpiamos los datos de subtitulos con el gpt
log_info "Cleaning subtitle data for fabric input"
#$pwd_tools_dir/clean_subtitles.sh $pwd_data_dir
cd $actual_pwd

# Convertimos los datos limpios a explicaciones de gpts
log_info "Converting cleaned subtitles to markdown explanations with fabric"
[ ! -d $instructional_dir/explanations ] && mkdir -p $instructional_dir/explanations
pwd_explanation_dir=$(pwd)/"$instructional_dir"explanations
#$pwd_tools_dir/create_explication.sh $pwd_data_dir  $pwd_explanation_dir

log_info "Converting all explanation in a final markdown explanation with fabric"
#cat $pwd_explanation_dir/*_explanation.md | fabric -sp juntar_explicaciones_md_bjj > $pwd_explanation_dir/final_explanation.md

log_info "Converting final explanation in a mermaid diagrams markdown"
#cat $pwd_explanation_dir/final_explanation.md | fabric -sp explanation_to_diagram_bjj > $pwd_explanation_dir/diagrams.md

log_info "Markdown to html conversion"
[ ! -d $instructional_dir/html ] && mkdir -p $instructional_dir/html
pwd_html_dir=$(pwd)/"$instructional_dir"html
rm $pwd_html_dir/* 2> /dev/null
$pwd_tools_dir/convert_markdown_to_html.sh $pwd_explanation_dir $pwd_html_dir $actual_pwd/plantilla
cd $actual_pwd

log_info "Beautifying html with fabric"
$pwd_tools_dir/convert_html_to_beautified.sh $pwd_html_dir
cd $actual_pwd

log_info "Extracting diagrams"
[ ! -d $instructional_dir/diagrams ] && mkdir -p $instructional_dir/diagrams
pwd_diagrams_dir=$(pwd)/"$instructional_dir"diagrams
rm $pwd_diagrams_dir/* 2> /dev/null
$pwd_tools_dir/extract_diagrams.sh $pwd_explanation_dir $pwd_diagrams_dir
cd $actual_pwd

log_info ""
log_info "--------------> All done! <----------------"
log_info "Markdown files are in $pwd_explanation_dir"
log_info "Html files are in $pwd_html_dir"
log_info "Diagrams are in $pwd_diagrams_dir"
log_info "Videos are in $pwd_videos_dir"
log_info "-------------------------------------------"

