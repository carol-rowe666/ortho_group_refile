#!/bin/bash

FILES="./*.afa"

for file in $FILES
do
	grep -H -n "^>" $file >> new_prot_names.txt
done

