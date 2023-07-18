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
outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs"
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/recal.marked.merged.NA12878.bam"
output_name="/scratch1/jlee0087/projects/exome_exercise/vcfs/threshold50.recal.marked.merged.NA12878.vcf"
gatk_path="/project/davidwcr_264/Packages/gatk/4.2.6.1/gatk-package-4.2.6.1-local.jar"
referencefasta="/scratch1/jlee0087/resources/b37/human_g1k_v37.fasta"

###########################
# COMMANDS
###########################
cd ${outputdir}

java -Xmx16g -jar ${gatk_path} HaplotypeCaller \
	-R ${referencefasta} \
	-I ${input_bam} \
	-O ${output_name} \
    --base-quality-score-threshold 50
 


