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
#outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs/"
input_vcf1="/scratch1/jlee0087/projects/case_study/test_BKPT_sorted.vcf"
#input_vcf2="/scratch1/jlee0087/projects/exome_exercise/vcfs/intersection/shared.reference.vcf"
#input_vcf3="/scratch1/jlee0087/projects/exome_exercise/vcfs/intersection/unique.input.vcf"
#input_vcf3="/scratch1/jlee0087/projects/exome_exercise/vcfs/intersection/unique.reference.vcf"



###########################
# COMMANDS
###########################
cd ${outputdir}

#bcftools view ${input_vcf1} -Oz -o ${input_vcf1}.gz

#bcftools view ${input_vcf2} -Oz -o ${input_vcf2}.gz

#bcftools view ${input_vcf3} -Oz -o ${input_vcf3}.gz
#bcftools view ${input_vcf4} -Oz -o ${input_vcf4}.gz


bcftools index -t ${input_vcf1}.gz

#bcftools index -t ${input_vcf2}.gz
#bcftools index -t ${input_vcf3}.gz
#bcftools index -t ${input_vcf4}.gz



 


