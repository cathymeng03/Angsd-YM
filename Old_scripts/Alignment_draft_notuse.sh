#! /bin/bash -i

# This script is for:
# Aligning raw fastq files used for the individual projects to proper ref genome

# Define arguments for this script
fastqfile_dir=$1
alignment_dir=$2

# To run STAR
# Define the reference genome for STAR alignment
# The reference genome should be mouse genome (mm10)
STAR_dir=/athena/angsd/scratch/yim4002/Individual_Project/mm10_ref

# Run STAR, if result not already present (should really check that genome directory exists)
for sample in ${alignment_dir}; do
  if [ ! -r ${alignment_dir}/${sample}_STAR.Aligned.sortedByCoord.out.bam ]; then
    echo "Running STAR alignment for $sample......"
    STAR --runThreadN 8 \
    --genomeDir $STAR_dir \
    --readFilesIn ${fastqfile_dir}/$sample_R1_001.fastq.gz ${fastqfile_dir}/$sample_R2_001.fastq.gz\
    --readFilesCommand zcat \
    --outFileNamePrefix ${alignment_dir}/${sample}_STAR. \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode TranscriptomeSAM GeneCounts
  else
    echo "Error: The sample fastq file has already been aligned through STAR program."
    exit
  fi
done

# Index the BAM file
for file in in ${alignment_dir}; do
  samtools index ${alignment_dir}/$file.Aligned.sortedByCoord.out.bam
done

