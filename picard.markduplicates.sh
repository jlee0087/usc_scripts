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
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/merged.NA12878.bam"
picard_path="/project/davidwcr_264/Packages/picard-tools/picard-2.9.0/picard.jar"
output_bam="/scratch1/jlee0087/projects/exome_exercise/bams/marked.merged.NA12878.bam"
marked_metrics="/scratch1/jlee0087/projects/exome_exercise/bams/marked_metrics.NA12878.txt"
###########################
# COMMANDS
###########################
cd ${outputdir}

java -Xmx16g -jar ${picard_path} MarkDuplicates \
	I=${input_bam} \
	O=${output_bam} \
	M=${marked_metrics}
 


