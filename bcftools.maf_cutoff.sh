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
input_vcf="/scratch1/jlee0087/projects/case_study/dbsnp.high.qual.sort.vcf"

output_vcf="/scratch1/jlee0087/projects/case_study/af.dbsnp.high.qual.sort.vcf"
###########################
# COMMANDS
###########################
cd ${outputdir}

bcftools view -i 'INFO/CAF < 0.001' ${input_vcf} > ${output_vcf}



 


