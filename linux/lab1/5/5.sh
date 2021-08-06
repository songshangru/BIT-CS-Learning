#!/bin/bash


cc -o fa f3.c f1.c f2.c
./fa

cc -c f1.c f2.c
ar crv libmyl.a f1.o f2.o
ranlib libmyl.a
cc -o fb f3.c libmyl.a
./fb

cc -shared -o libmy.so f1c.c f2c.c
cc -o fcc f3c.c -ldl
./fcc
