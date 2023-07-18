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
module load gcc/11.3.0 openjdk/11.0.15_10

###########################
# VARIABLES
###########################

referencefasta="/scratch1/jlee0087/resources/b37/human_g1k_v37.fasta"
outputfile="/scratch1/jlee0087/resources/b37/human_g1k_v37.dict"
picard_path="/project/davidwcr_264/Packages/picard-tools/picard-2.9.0/picard.jar"
###########################
# COMMANDS
###########################

java -Xmx16g -jar ${picard_path} CreateSequenceDictionary \
	R=${referencefasta} \
	O=${outputfile}


