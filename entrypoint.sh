#!/bin/bash
set -e

cmd=()

# force backup destination
if [ "$1" = time2backup ] ; then
  cmd=(time2backup -d /backups)
  shift
fi

exec "${cmd[@]}" "$@"
