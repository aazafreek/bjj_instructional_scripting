#!/bin/bash

explanation_dir=$1
diagram_dir=$2

cd $explanation_dir
npx mmdc -e pdf -t forest -f -i diagrams.md -o $diagram_dir/diagram.pdf &> /dev/null

