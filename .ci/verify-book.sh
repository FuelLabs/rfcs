#!/usr/bin/env bash

set -e

pushd text
# Verify that all RFC texts are included in the SUMMARY.md file
find .  -regex '\./rfcs/[0-9][0-9][0-9][0-9].*.md$' -type f | xargs -I '{}' bash -c "grep -q {} SUMMARY.md && true || (echo 'Missing RFC in SUMMARY.md: {}'; (exit 1))"
