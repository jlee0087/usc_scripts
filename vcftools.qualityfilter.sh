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
module load gcc/11.3.0 vcftools
###########################
# VARIABLES
###########################
input_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/annotated.NA12878.vcf"
output_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/variant_filter.NA12878.vcf"

###########################
# COMMANDS
###########################
vcftools --vcf ${input_vcf} --minQ 500 --recode --out ${output_vcf}