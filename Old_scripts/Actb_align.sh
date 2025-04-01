#! /bin/bash -i

# This script is for:
# Filter the STAR-aligned Bam files for my project to only the Actb region in 3-7-25 assginment: Visualizing in IGV

# Define the directory where my aligned BAM files are contained  
# Define the output directory
BAM_file_dir=$1
Output_dir=$2

for file in ${BAM_file_dir}/*_Aligned.sortedByCoord.out.bam; do

  # Extract filename for each BAM file it loops through
  Basename=$(basename "$file" _Aligned.sortedByCoord.out.bam)

  echo "Processing sample file of $Basename......"

  # Define a variable for output file
  Output_file="${Output_dir}/${Basename}.actb.bam"

  # Use samtools view -b command to filter the BAM file for the Actb region
  # and then index the output file
  samtools view -b "$file" chr5:142903115-142906754 > "$Output_file"
  samtools index "$Output_file"

  echo "Sample file $Basename Processed......"

done

