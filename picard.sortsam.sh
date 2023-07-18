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
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/HG00096.chrom11.ILLUMINA.bwa.GBR.exome.20120522.bam"
picard_path="/project/davidwcr_264/Packages/picard-tools/picard-2.9.0/picard.jar"
output_bam="/scratch1/jlee0087/projects/exome_exercise/bams/sample.bam"

###########################
# COMMANDS
###########################
cd ${outputdir}

java -Xmx16g -jar ${picard_path} SortSam \
	I=${input_bam} \
	O=${output_bam} \
	SORT_ORDER=coordinate
 


