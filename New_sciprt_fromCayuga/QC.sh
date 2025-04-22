#! /bin/bash -i

# This script is for:
# Perform QC to all raw fastq files

# Define arguments for this script
fastqfile_dir=$1
QC_dir=$2

# To run QC of all files:
for file in ${fastqfile_dir}/*.fastq.gz; do
    fastqc "$file" -o ${QC_dir}
done
