#!/bin/sh

###########################
# SLURM
###########################
#SBATCH --cpus-per-task=16
#SBATCH --partition=dtg
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=24:00:00
###########################
# SETUP
###########################
module load gcc/11.3.0 subread

###########################
# VARIABLES
###########################
gtf_path="/scratch1/jlee0087/introCarc/references/sourceFiles/gencode.v29.primary_assembly.annotation.gtf"
bam_path=(
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3186_2662_da0_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3186_2662_da25_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3186_2662_da65_v3Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3220_6139_da0_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3220_6139_da25_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3220_6139_da65_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3234_1338_da0_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3234_1338_da25_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3234_1338_da65_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3409_0660_da0_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3409_0660_da25_v1Aligned.sortedByCoord.out.bam"
    "/scratch1/jlee0087/introCarc/alignmentruns/alignment_230212/bams/RNAB_PPMI3409_0660_da65_v2Aligned.sortedByCoord.out.bam"
)



OUTPUT_DIR="/scratch1/jlee0087/projects/RNAseq_tut/featurecounts"

###########################
# COMMANDS
###########################



for BAM in "${bam_path[@]}"
do
    SAMPLE_NAME=$(basename "$BAM" .bam)


    featureCounts -a "$gtf_path" -o "$OUTPUT_DIR/${SAMPLE_NAME}_counts.txt" -p -B -C -T 4 -s 0 "$BAM"
done

