#!/bin/bash

log_info() {
	echo -e "\e[32m[INFO]\e[0m $1"
}

MP4_DIR=$1
INSTRUCTIONAL_NAME=$2
REPO_BASE_PATH=${3:-.}

OUTPUT_BASE_DIR=$REPO_BASE_PATH/$INSTRUCTIONAL_NAME
SUBTITLE_DIR=$OUTPUT_BASE_DIR/subtitles
EXPLANATION_DIR=$OUTPUT_BASE_DIR/explanations

mkdir -p $OUTPUT_BASE_DIR
mkdir -p $SUBTITLE_DIR
mkdir -p $EXPLANATION_DIR

log_info "Creating subtitles for $INSTRUCTIONAL_NAME"
$REPO_BASE_PATH/tools/create_subtitles.sh $MP4_DIR $SUBTITLE_DIR

log_info "Cleaning subtitles"
$REPO_BASE_PATH/tools/clean_subtitles.sh $SUBTITLE_DIR

log_info "Using fabric to create explanation files"
$REPO_BASE_PATH/tools/create_explanation.sh $SUBTITLE_DIR $EXPLANATION_DIR

# log_info "Converting all explanation in a final markdown explanation with fabric"
# cat $pwd_explanation_dir/*_explanation.md | fabric -sp juntar_explicaciones_md_bjj > $pwd_explanation_dir/final_explanation.md

# log_info "Converting final explanation in a mermaid diagrams markdown"
# cat $pwd_explanation_dir/final_explanation.md | fabric -sp explanation_to_diagram_bjj > $pwd_explanation_dir/diagrams.md

# log_info "Markdown to html conversion"
# [ ! -d $instructional_dir/html ] && mkdir -p $instructional_dir/html
# pwd_html_dir=$(pwd)/"$instructional_dir"html
# rm $pwd_html_dir/* 2> /dev/null
# $pwd_tools_dir/convert_markdown_to_html.sh $pwd_explanation_dir $pwd_html_dir $actual_pwd/plantilla
# cd $actual_pwd

# log_info "Beautifying html with fabric"
# $pwd_tools_dir/convert_html_to_beautified.sh $pwd_html_dir
# cd $actual_pwd

# log_info "Extracting diagrams"
# [ ! -d $instructional_dir/diagrams ] && mkdir -p $instructional_dir/diagrams
# pwd_diagrams_dir=$(pwd)/"$instructional_dir"diagrams
# rm $pwd_diagrams_dir/* 2> /dev/null
# $pwd_tools_dir/extract_diagrams.sh $pwd_explanation_dir $pwd_diagrams_dir
# cd $actual_pwd

# log_info ""
# log_info "--------------> All done! <----------------"
# log_info "Markdown files are in $pwd_explanation_dir"
# log_info "Html files are in $pwd_html_dir"
# log_info "Diagrams are in $pwd_diagrams_dir"
# log_info "Videos are in $pwd_videos_dir"
# log_info "-------------------------------------------"

