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
input_vcf="/scratch1/jlee0087/projects/case_study/hom.high.qual.db.bkpt.sort.vcf"
output_name="/scratch1/jlee0087/projects/case_study/temp.dbnsfp.ann.vcf"
snpeffpath="/project/davidwcr_264/Packages/snpEff_new/4.3/"
dbnsfpath="/scratch1/jlee0087/projects/exome_exercise/dbnsfp/dbNSFP4.1a.txt.gz"
###########################
# COMMANDS
###########################
cd $workingDir
java  -Xmx16g -jar ${snpeffpath}/SnpSift.jar dbnsfp -db ${dbnsfpath} ${input_vcf} > ${output_name}

