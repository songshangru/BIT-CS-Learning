#!/bin/bash

mkdir ./a
mkdir ./b

cd ./a
touch ./1.c
touch ./2.c
touch ./3.c
touch ./4.c

for i in `ls | grep -E "*\.c"`
do
  cp $i ../b/
done

cd ../

ls -LS ./b
