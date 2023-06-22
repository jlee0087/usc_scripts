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
module load gcc/8.3.0 snpeff

###########################
# VARIABLES
###########################
workingDir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
bamDir="/scratch1/jlee0087/projects/exome_exercise/bams"

###########################
# COMMANDS
###########################
cd $workingDir
snpEff eff GRCh37.75 $workingDir/NA12878.freebayes.vcf > $workingDir/NA12878.freebayes.snpeff.vcf

