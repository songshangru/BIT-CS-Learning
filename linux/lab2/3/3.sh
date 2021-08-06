#!/bin/bash


dir=$(ls -l ./ |awk '/^d/ {print $NF}')
for i in $dir
do
  echo $i
done
