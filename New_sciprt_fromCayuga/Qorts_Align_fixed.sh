#!/bin/bash

# This is the script for using QoRTs package to perform analysis on and generate plots for read distribution and gene body coverage.
# Copied and edited from the old "Qorts_Align.sh" script
# To run on new STAR-aligned and indexed BAM files under "Fixed_analysis" dir
# For my project's data

# Define the argument for input BAM directory, GTF reference file, and output directory

BAM_file_dir=$1
GTF_file=$2
Output_dir=$3

# Define the for loop to loop through all bam files in the target directory:
for file in ${BAM_file_dir}/*_Aligned.sortedByCoord.out.bam; do

    # Extract sample name
    Sample_name=$(basename "$file" _Aligned.sortedByCoord.out.bam)
  
    echo "$Sample_name is being processed......"
  
    # Run QoRTs QC for all samples
    # Specify the QoRTs.jar file
    # Our data is paired-ended so that I don't need to specifcy (by default)
    # Our data is non-stranded so that I don't need to specify (by default)
    java -jar /athena/angsd/scratch/yim4002/angsd_hw/QoRTs.jar QC \
        --generatePlots \
        $file \
        ${GTF_file} \
        ${Output_dir}/"$Sample_name"/

done

echo "✅ All sample files chosen were processed!"