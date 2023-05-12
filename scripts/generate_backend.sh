#!/bin/bash

# Generate terraform backend from template
# Params:
#   - TARGET_DIR: Directory to generate backend files
#   - S3_BUCKET: S3 Bucket name
#   - REGION: AWS Region
#   - KEY: S3 Bucket key

TARGET_DIR=$1
S3_BUCKET=$2
REGION=$3
KEY=$4

cd "${TARGET_DIR}" || exit

test -d ./.venv || python3 -m venv ./.venv
source ./.venv/bin/activate
pip install jinja2-cli==0.8.2 Jinja2==3.1.2

for file in $(find .. -type f -name "backend.jinja")
do
  jinja2 "${file}" \
    -D region="${REGION}" \
    -D s3_bucket="${S3_BUCKET}" \
    -D key="${KEY}" > "${file%.jinja}.tf"
  
  cat "${file%.jinja}.tf"
done
