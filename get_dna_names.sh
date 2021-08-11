#!/bin/bash

FILES="/path/to/PAL2NAL/All_the_cds_files/Unpickled_cds_files/*.fa"

for file in $FILES
do
	grep -H -n "^>" $file >> dna_names.txt
done

