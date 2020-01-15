#!/usr/bin/env bash

# Plays and records all *-ascriiptnema.sh files in a folder
# rec-ascriiptnema.sh /some/folder

path=$1
oldpath=`pwd`
cd $path
for ascriipt in $path/*-ascriiptnema.sh; do
  cast=`echo $ascriipt | sed -e s/-ascriiptnema.sh/.cast/`
  echo "Script: $ascriipt"
  echo "Cast: $cast"
  resize -s 24 80 &>/dev/null
  rm $cast
  clear
  asciinema rec -c "ascriiptnema $ascriipt" $cast
done
cd $oldpath