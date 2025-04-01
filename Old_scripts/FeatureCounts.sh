#!/bin/bash

# This is the script for using FeatureCounts to quantify my aligned reads
# For my project's data

featureCounts \
  -a ./Fixed_analysis/mm10.refGene.gtf \
  -o ./3_31_25_FeatureCounts/mT5_RNAseq_gene_counts.txt \
  -t exon \
  -g gene_id \
  -T 32 \
  -p \
  -s 0 \
  --ignoreDup \
  ./Alignment_dir/BAM_duplicates_marked/*_Aligned.sortedByCoord.out.marked.bam
