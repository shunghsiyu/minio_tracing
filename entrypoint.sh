#!/bin/sh
set -o errexit
set -o nounset
trace_regex=$1

# Run distributed minio
exec dlv trace $trace_regex -- server \
	$HOME/minio_A \
	$HOME/minio_B \
	$HOME/minio_C \
	$HOME/minio_D
