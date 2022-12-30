#!/bin/sh
grep -c [^_]ERR ../src/libswe/*.[ch]
echo "### replacing ERR"
sed -i 's/ERR/SE_ERR/g' ../src/libswe/*.[ch]
grep -c [^_]ERR ../src/libswe/*.[ch]

