#!/bin/bash



num=20
answer=1
for i in `seq 1 $num`
do
  answer=$(($answer*$i))
done
echo $answer
