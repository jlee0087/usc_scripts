#!/bin/sh

###########################
# SLURM
###########################
#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=24:00:00
###########################
# SETUP
###########################
module load gcc/11.3.0 samtools

###########################
# VARIABLES
###########################
bam1="/scratch1/jlee0087/projects/exome_exercise/bams/lane1.NA12878.l1.sort.bam"
bam2="/scratch1/jlee0087/projects/exome_exercise/bams/lane2.NA12878.l2.sort.bam"
output_name="merged.NA12878.bam"
sorted_name="sorted.merged.NA12878.bam"
###########################
# COMMANDS
###########################

cd /scratch1/jlee0087/projects/exome_exercise/bams

samtools merge ${output_name} ${bam1} ${bam2}

samtools index ${output_name}


