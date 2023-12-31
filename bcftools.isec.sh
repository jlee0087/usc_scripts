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
outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs/intersection"
input_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/canon.annotated.variant_filter.NA12878.vcf.gz"
reference_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/Homo_sapiens_assembly19_1000genomes_decoy_Homo_sapiens_assembly19_1000genomes_decoy.variantEvalGoldStandard.vcf.gz"

###########################
# COMMANDS
###########################
mkdir ${outputdir}

bcftools isec -p ${outputdir} ${input_vcf} ${reference_vcf}
 


