# Switching protein sequences with corresponding DNA sequences from separate files.
  
**PROTEIN files:**  
There are 143 of these .fa files where each file represents an ortho-group. Each file contains several names (headers) and protein sequences in the following format:  
\>header name  
protein sequence  

**DNA files:**  
There are 21 .fa files where each file represents a plant species. Format is same as protein files, except these have DNA sequences (not protein).
  
### GOAL:  
Want to keep the structure of the protein files (keep the same 143 files where each file has the same order of headers), EXCEPT we want to replace the protein sequences with the corresponding DNA sequences. From the 143 protein files, there are a total of 6,161 sequences (some files have many more sequences than others). From the 21 DNA files, there are a total of 608,991 sequences. Hence, it's not an easy 1-to-1 matching process. To get the 6,161 sequence conversions, you can first look for matching headers between the protein and DNA sequence headers. This works for 3,946 of them. That leaves 2,215 names/headers where we have to use regular expressions to find the coresponding, matching names.  
  
### HOW IT WORKS:  
**1.)** Bash scripts to get all header names.  
Each script goes to the directory (used current directory *./* and */full/path/to/files/* fur fun so you can see how it behaves).  
For each file in the directory, I use grep to get both the file name with directory, -H, and the file line number, -n, along with the full header name (lines starting with \>: "^\>". This all gets appended to the outputfile.  
Example grep line: **grep -H -n "^>" $file >> new_prot_names.txt**  
  
SCRIPT: get_prot_names.sh  
OUTPUT: prot_names.txt  
  
SCRIPT: get_dna_names.sh  
OUTPUT: dna_names.txt  
  
**2.)** python script to find headers with direct matches, and then use regular expressions to find the more obscure name matches.  
* Read the bash .txt output files into a pandas dataframes (df). This then requires a little "cleaning" to get the 2 resulting .csv files each with 3 columns:  
file basename  
line number  
header name  
* merge the 2 .csv files. Use the pd.merge command with how='outer' and create an output indicator column named "how". You can see the exact name matches where the resulting df "how" column has values of "both". Set that fraction of the df aside (3,946 rows). Focus on the subset where there were no direct matches for the prot header names (2,215 rows) - call this prot_df, and the corresponding unmatched dna subset the dna_df.   
* create a function to apply to the prot_df (and the dna_df) whereby we create a new column, "Name" which contains a subset of the header that is found in BOTH the prot_df and the dna_df. Creating this function will take a little but of detective work.  
* after applying the function, merge the prot_df and the dna_df using pd.merge: 
name_merge2 = pd.merge(prot1, dna11, on='Name', how='outer', indicator='how')  
You'll see that all 2,215 remaining headers all matched ('how' column with value "both") - and matched only a single time (i.e. no bad regeular expressions where we had multiple hits).  
* now, merge this with the df where we had identical name matches.
* output is a df with 6,161 rows and 6 columns (prot file name, prot file line number, prot header, dna file name, dna file number, and common name)
  
 **3.)** use output "final_dna_line_head_num.csv" to write new files to a new directory. The df has all the file names and line numbers so we know where to get the correct dna sequence to srite to the file with the correct header from the protein file. We use the linenumber and the python library: linecache to grab the dna sequence. This just gets the desired line without having to open the entire, large, dna sequence files.
