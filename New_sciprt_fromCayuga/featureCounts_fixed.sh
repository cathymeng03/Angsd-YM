#!/bin/bash

# This is the script for using FeatureCounts to quantify my aligned reads
# Edited for the new aligned marked bam files generated
# For my project's data: mT5 samples

featureCounts \
  -a ./Fixed_analysis/mm10.refGene.gtf \
  -o ./Fixed_analysis/3_31_25_FIxed_FeatureCounts/mT5-RNAseq_gene_counts_fixed.txt \
  -t exon \
  -g gene_id \
  -T 8 \
  -p \
  -s 0 \
  --ignoreDup \
  ./Fixed_analysis/3_31_25_FIxed_FeatureCounts/Marked_BAM_FromFixedAlign/*.marked.bam
