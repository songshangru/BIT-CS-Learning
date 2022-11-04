#!/bin/bash


cnt=0
while read line
do
  if [ $cnt -eq 0 ];then
    max=$line
    min=$line
  fi
  [ $max -lt $line ] && max=$line  
  [ $min -gt $line ] && min=$line
  let cnt++
  let sum+=$line
done<file
echo "max=$max"
echo "min=$min"
echo "ave=` echo "base=10; scale=2; ${sum}/${cnt}" | bc`"
