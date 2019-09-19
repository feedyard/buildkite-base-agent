#!/usr/bin/env bash
set -eu
echo 'agent environment hook'

# setup credentials to read environment config
mkdir -p ~/.aws

cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id=${VAL1}
aws_secret_access_key=${VAL2}
region=us-east-1
EOF
