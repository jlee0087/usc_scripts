#!/bin/sh

# SLURM
#####################
#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=24:00:00
#####################
# SETUP
#####################
module load gcc/11.3.0 freebayes

cd "/scratch1/jlee0087/projects/exome_exercise/bams"

outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/NA12878.l1.sort.bam"
outputname="NA12878.freebayes.vcf"
mkdir -p $outputdir
# Make sure the fasta sequence is in your directory, or you have made a symbolic link to it
gunzip /scratch1/jlee0087/resources/b37/human_g1k_v37.fasta.gz



freebayes -f /scratch1/jlee0087/resources/b37/human_g1k_v37.fasta ${input_bam} > $outputdir/$outputname

