#!/bin/bash
set -x

REPO_BASE_PATH=${1:-.}

rm -rf ~/.config/fabric/patterns/*

cp -r $REPO_BASE_PATH/patterns/* ~/.config/fabric/patterns

fabric --updatepatterns
fabric -l
