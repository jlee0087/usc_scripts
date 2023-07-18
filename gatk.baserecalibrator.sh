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
input_bam="/scratch1/jlee0087/projects/exome_exercise/bams/rg.marked.merged.NA12878.bam"
output_name="recal.marked.merged.NA12878.table"
gatk_path="/project/davidwcr_264/Packages/gatk/4.2.6.1/gatk-package-4.2.6.1-local.jar"
referencefasta="/scratch1/jlee0087/resources/b37/human_g1k_v37.fasta"
outputdir="/scratch1/jlee0087/projects/exome_exercise/vcfs/"
knownsites="/scratch1/jlee0087/projects/exome_exercise/vcfs/Homo_sapiens_assembly19_1000genomes_decoy.variantEval.dbsnp.vcf"
###########################
# COMMANDS
###########################
cd ${outputdir}

java -Xmx16g -jar ${gatk_path} BaseRecalibrator \
	-R ${referencefasta} \
	-I ${input_bam} \
	--known-sites ${knownsites} \
	-O ${output_name}
 

