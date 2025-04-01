#! /bin/bash -i

# Since there is a typo in the Alignment.sh script, redo the Indexing after STAR from here:
# Index all the aligned BAM file
alignment_dir=$1
index_output_dir=$2

for file in ${alignment_dir}/*.fastq.gz_Aligned.sortedByCoord.out.bam; do
  samtools index -o "${index_output_dir}/$(basename "$file").bai" "$file"
done
