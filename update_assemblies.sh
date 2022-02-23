#!/bin/bash

## Enter into NCBI Assembly and execute the follow search
## ("Bacteria"[Organism]) AND ((latest[filter] OR "latest refseq"[filter]) AND "representative genome"[filter] OR "reference genome"[filter] AND all[filter] NOT anomalous[filter])

rm assembly*

wget -O assembly_summary_refseq.txt ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/assembly_summary.txt

grep 'reference genome' assembly_summary_refseq.txt > tmp
grep 'representative genome' assembly_summary_refseq.txt >> tmp

echo -e 'assembly_accession\tspecies_taxid\torganism_name' > header_class.tsv

cut -f 1,7,8 tmp >> header_class.tsv

mkdir faa
mkdir fna

tar xvf genome_assemblies_genome_fasta.tar -C ./fna
tar xvf genome_assemblies_prot_fasta.tar -C ./faa

ls $PWD/faa/*/*.gz > list_faa 
ls $PWD/fna/*/*.gz > list_fna

mash sketch -l list_fna -p 20 -o ReferenceNucl.msh
mash sketch -l list_faa -a -p 20 -o ReferenceProt.msh 


mkdir toTar
mv VFDB_set* toTar/
mv resfinder_* toTar/
mv headers* toTar/
mv annot.data toTar/
mv bacmet* toTar/
mv header_class.tsv toTar/
mv ReferenceNucl.msh toTar/
mv ReferenceProt.msh toTar/

tar -czvf patodb.tar.gz ./toTar/*

# clean the folder and commit to github

