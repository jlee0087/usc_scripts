#!/bin/sh

###########################
# SLURM
###########################
#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=24:00:00
#SBATCH --partition=dtg
###########################
# SETUP
###########################
module load gcc/11.3.0 openblas/0.3.20 bcftools/1.14

###########################
# VARIABLES
###########################
outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs/"
input_vcf="/scratch1/jlee0087/projects/case_study/CRDC0005_FAM32.snpeff.vcf"

output_vcf="/scratch1/jlee0087/projects/case_study/temp.vcf"
###########################
# COMMANDS
###########################
cd ${outputdir}

bcftools view -i 'INFO/ANN~"HIGH"' ${input_vcf} > ${output_vcf}



 


