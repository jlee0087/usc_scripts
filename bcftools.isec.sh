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
module load gcc/11.3.0 bcftools/1.14

###########################
# VARIABLES
###########################
outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
input_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/snpeff.threshold50.recal.marked.merged.NA12878.vcf"
reference_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/Homo_sapiens_assembly19_1000genomes_decoy_Homo_sapiens_assembly19_1000genomes_decoy.variantEvalGoldStandard.vcf"

###########################
# COMMANDS
###########################
cd ${outputdir}

bcftools isec -p ${outputdir} ${input_vcf} ${reference_vcf}
 


