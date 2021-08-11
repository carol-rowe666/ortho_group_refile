#!/bin/bash

FILES="./*.afa"

for file in $FILES
do
	grep -H -n "^>" $file >> prot_names.txt
done

