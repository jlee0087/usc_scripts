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
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/marked.merged.NA12878.bam"
output_bam="/scratch1/jlee0087/projects/exome_exercise/bams/rg.marked.merged.NA12878.bam"

path="/scratch1/jlee0087/projects/exome_exercise/bams/"
###########################
# COMMANDS
###########################
cd ${path}

samtools addreplacerg -r "ID:group1" -r "LB:library1" -r "PL:illumina" -r "SM:sample1" -o ${output_bam} ${input_bam}

 


