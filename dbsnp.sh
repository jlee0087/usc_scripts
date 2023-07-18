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


###########################
# VARIABLES
###########################
module load gcc/11.3.0

cd /scratch1/jlee0087/projects/exome_exercise/vcfs/

wget https://storage.googleapis.com/gcp-public-data--broad-references/Homo_sapiens_assembly19_1000genomes_decoy/Homo_sapiens_assembly19_1000genomes_decoy.variantEval.dbsnp.vcf

###########################
# COMMANDS
###########################
