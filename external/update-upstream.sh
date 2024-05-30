#!/bin/sh
for f in ../src/libswe/*.[ch]
do
    g=$(basename $f)
    cp swisseph/$g $f
done

for f in ../inst/ephemeris/*.txt
do
    g=$(basename $f)
    find . -name $g -exec cp \{\} $f \;
done
