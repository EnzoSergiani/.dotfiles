#!/usr/bin/env bash
ps -eo comm,%cpu --sort=-%cpu 2>/dev/null | awk 'NR==2 {print "TOP" $1}'
