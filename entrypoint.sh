#!/bin/sh
set -o errexit
set -o nounset
trace_regex=$1

# Create temporary directories to run distributed minio
tmp1=$(mktemp -d)
tmp2=$(mktemp -d)
tmp3=$(mktemp -d)
tmp4=$(mktemp -d)

# Always clean up temporary directory
clean_temp() {
  rm -rf $tmp4 $tmp3 $tmp2 $tmp1
}
trap clean_temp EXIT

# Run distributed minio
dlv trace $trace_regex -- server $tmp1 $tmp2 $tmp3 $tmp4 && \
kill $!
