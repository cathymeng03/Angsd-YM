#! /bin/bash -i

# The previous aligned BAM files do not have duplicates marked
# This script aims to mark the duplicates in reads
# My original BAM files: do not contain mate information (MC tag) needed for markdup to identify paired reads and their duplicates.
# So here is some additional steps I need to go before I run "samtools markup"
   # Convert BAM → name-sorted BAM (samtools collate)
   # Add mate info (samtools fixmate)
   # Sort by coordinates again (samtools sort)


# Define arguments for input and output directories when running this script

alignment_dir=$1   # Input directory with STAR BAMs
output_dir=$2      # Output directory for marked BAMs

for bamfile in ${alignment_dir}/*_Aligned.sortedByCoord.out.bam; do
  echo "Processing $bamfile..."

  # Extract base name
  sample_name=$(basename "$bamfile" .bam)

  # Define intermediate and final output file names
  name_sorted_bam="${output_dir}/${sample_name}.name_sorted.bam"
  fixmate_bam="${output_dir}/${sample_name}.fixmate.bam"
  coord_sorted_bam="${output_dir}/${sample_name}.coord_sorted.bam"
  marked_bam="${output_dir}/${sample_name}.marked.bam"

  # Step 1: Name sort
  samtools collate -o "$name_sorted_bam" "$bamfile"

  # Step 2: Fixmate
  samtools fixmate -m "$name_sorted_bam" "$fixmate_bam"

  # Step 3: Sort by coordinate
  samtools sort -o "$coord_sorted_bam" "$fixmate_bam"

  # Step 4: Mark duplicates (do NOT remove)
  samtools markdup -s "$coord_sorted_bam" "$marked_bam"

  # Step 5: Index final BAM
  samtools index "$marked_bam"

  echo "✅ Finished: $marked_bam"
  
  # Clean up intermediates to save space:
  rm "$name_sorted_bam" "$fixmate_bam" "$coord_sorted_bam"
done
