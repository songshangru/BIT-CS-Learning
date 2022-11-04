#!/bin/bash

function get_average_time()
{
    start=$(date +%s%N)
    for i in {1..5}
    do
        eval $1 > /dev/null 2>&1
    done
    end=$(date +%s%N)
    echo 运行5次平均用时： $((($end - $start) /5000000 ))毫秒
}

echo C
cd ./C/bin
get_average_time './Qsort'
cd ../../

echo Java
cd ./Java/bin
get_average_time 'java Qsort'
cd ../../

echo Python
cd ./Python/src
get_average_time 'python3 Qsort.py'
cd ../../

echo Haskell
cd ./Haskell/src
get_average_time 'runghc Qsort.hs'
cd ../../
