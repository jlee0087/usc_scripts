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
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/lane2.NA12878.l2.sort.bam"
picard_path="/project/davidwcr_264/Packages/picard-tools/picard-2.9.0/picard.jar"

###########################
# COMMANDS
###########################
cd ${outputdir}

java -Xmx16g -jar ${picard_path} AddOrReplaceReadGroups \
	I=${input_bam} \
	O=${input_bam} \
	RGID=2 \
	RGLB=library \
	RGPL=illumina \
	RGPU=unit \
	RGSM=sample
 


