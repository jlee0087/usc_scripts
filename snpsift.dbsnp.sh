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
module load gcc/11.3.0 openjdk/11.0.15_10

###########################
# VARIABLES
###########################
input_vcf="/scratch1/jlee0087/projects/case_study/high.qual.db.sort.vcf"
output_name="/scratch1/jlee0087/projects/case_study/dbsnp.high.qual.sort.vcf"
snpeffpath="/project/davidwcr_264/Packages/snpEff_new/4.3/"
dbsnppath="/scratch1/jlee0087/resources/00-All.vcf.gz"
###########################
# COMMANDS
###########################
cd $workingDir
java  -Xmx16g -jar ${snpeffpath}/SnpSift.jar annotate ${dbsnppath} ${input_vcf} > ${output_name}

