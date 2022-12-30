#!/bin/sh
for f in ../src/libswe/*.[ch]
do
    g=$(basename $f)
    cp swisseph/$g $f
done
