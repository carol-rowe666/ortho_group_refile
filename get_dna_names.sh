#!/bin/bash

FILES="/home/carol/Dropbox/Paul_and_Carol_Shared/Rijan_ortho/PAL2NAL/All_the_cds_files/Unpickled_cds_files/*.fa"

for file in $FILES
do
	grep -n -H "^>" $file >> num_dna_names.txt
done

