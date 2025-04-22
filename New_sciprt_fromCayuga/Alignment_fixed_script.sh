#! /bin/bash -i

# This script is for:
# Aligning raw fastq files used for the individual projects to proper ref genome

# Define arguments for this script
fastqfile_dir=$1
alignment_dir=$2

# To run STAR
# Define the reference genome for STAR alignment
# The reference genome should be mouse genome (mm10)
STAR_dir=/athena/angsd/scratch/yim4002/Individual_Project/mm10_ref/

# Run STAR, use for loop to align all sample fastq files
# Because the RNAseq is paired-end, there are 2 read files, R1 and R2
# Need to define R1/R2 files that belong to same sample in for loop
for R1 in ${fastqfile_dir}/*_R1_001.fastq.gz; do
  # Define the corresponding R2 file
  R2="${R1/_R1_001.fastq.gz/_R2_001.fastq.gz}"
  
  # Check if R2 exists (for paired-end files)
  if [ -f "$R2" ]; then
    echo "Aligning $R1 and $R2..."

    # Derive sample prefix (optional cleanup)
    sample_prefix=$(basename "$R1" _L003_R1_001.fastq.gz)

    #Run STAR Alignment
    STAR --runThreadN 32 \
    --runMode alignReads \
    --genomeDir $STAR_dir \
    --readFilesIn "$R1" "$R2" \
    --readFilesCommand zcat \
    --outFileNamePrefix ${alignment_dir}/${sample_prefix}_ \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode TranscriptomeSAM GeneCounts
  
  else
    echo "R2 file for $R1 not found! Skipping..."
  fi

done

# Index all the aligned BAM file
# Change the syntax error of the script from previous draft
for bamfile in ${alignment_dir}/*_Aligned.sortedByCoord.out.bam; do
  echo "Indexing $bamfile..."
  samtools index "$bamfile"
done