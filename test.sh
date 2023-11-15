#!/bin/zsh

me=$(basename "$0")

for f in *; do
  if [ "$me" = "$f" ] 
  then
    continue;
  fi

  mkdir -p "${f%%.*}"
  mv "$f" "${f%%.*}/index.md"
done


