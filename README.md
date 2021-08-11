# Switching protein sequences with corresponding DNA sequences from separate files.

**PROTEIN files:**
There are 143 of these .fa files where each file represents an ortho-group. Each file contains several names (headers) and protein sequences in the following format:
>header name
protein sequence

**DNA files:**
There are 21 .fa files where each file represents a plant species. Format is same as protein files, except these have DNA sequences (not protein).

### GOAL:
Want to keep the structure of the protein files (keep the same 143 files where each file has the same order of headers), EXCEPT we want to replace the protein sequences with the corresponding DNA sequences. From the 143 protein files, there are a total of 6,161 sequences (some files have many more sequences than others). From the 21 DNA files, there are a total of 608,991 sequences. Hence, it's not an easy 1-to-1 matching process. To get the 6,161 sequence conversions, you can first look for matching headers between the protein and DNA sequence headers. This works for 3,946 of them. That leaves 2,215 names/headers where we have to use regular expressions to find the matching names.
