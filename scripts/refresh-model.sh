#!/bin/bash

REPO_BASE_PATH=${1:-.}

mkdir -p /tmp/gen-subs/models
cd /tmp/gen-subs/models

wget https://alphacephei.com/vosk/models/vosk-model-en-us-0.22.zip

unzip vosk-model-en-us-0.22.zip
