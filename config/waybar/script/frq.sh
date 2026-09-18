#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

FRQ=$(awk '/cpu MHz/ {sum+=$4; n++} END {if (n>0) printf "%d", sum/n; else print 0}' /proc/cpuinfo)

printf "FRQ%d\n" "$(safe_num "$FRQ")"
