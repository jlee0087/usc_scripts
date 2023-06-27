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
module load gcc/8.3.0 snpeff openjdk

###########################
# VARIABLES
###########################
workingDir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
bamDir="/scratch1/jlee0087/projects/exome_exercise/bams"
snpeffpath="/project/davidwcr_264/Packages/snpEff_new/4.3/"
###########################
# COMMANDS
###########################
cd $workingDir
java -Xmx16g -jar $snpeffpath/snpEff.jar GRCh37.75 $workingDir/NA12878.freebayes.vcf > $workingDir/NA12878.freebayes.snpeff.vcf

