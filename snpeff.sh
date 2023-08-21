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
workingDir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
input_vcf="/scratch1/jlee0087/projects/exome_exercise/vcfs/recal.marked.merged.NA12878.vcf"
output_name="/scratch1/jlee0087/projects/exome_exercise/vcfs/annotated.NA12878.vcf"
snpeffpath="/project/davidwcr_264/Packages/snpEff_new/4.3/"
###########################
# COMMANDS
###########################
cd $workingDir
java -Xmx16g -jar $snpeffpath/snpEff.jar GRCh37.75 ${input_vcf} > ${output_name}

