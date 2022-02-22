#!/bin/bash

## Enter into NCBI Assembly and execute the follow search
## ("Bacteria"[Organism]) AND ((latest[filter] OR "latest refseq"[filter]) AND "representative genome"[filter] OR "reference genome"[filter] AND all[filter] NOT anomalous[filter])

rm assembly*

wget -O assembly_summary_refseq.txt ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/assembly_summary.txt

grep 'reference genome' assembly_summary_refseq.txt > tmp
grep 'representative genome' assembly_summary_refseq.txt >> tmp

echo -e 'assembly_accession\tspecies_taxid\torganism_name' > header_class.tsv

cut -f 1,7,8 tmp >> header_class.tsv

