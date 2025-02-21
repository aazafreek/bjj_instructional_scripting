#!/bin/bash
set -x
S3_BUCKET=$1
S3_FOLDER=$2
DESTINATION_FOLDER=$3

aws s3 cp s3://$S3_BUCKET/$S3_FOLDER $DESTINATION_FOLDER --recursive --include "*.mp4"
