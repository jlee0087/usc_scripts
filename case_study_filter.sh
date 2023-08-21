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
module load gcc/11.3.0 openjdk/11.0.15_10 openblas/0.3.20 bcftools/1.14

###########################
# VARIABLES
###########################
workingDir="/scratch1/jlee0087/projects/case_study"
input_vcf="/scratch1/jlee0087/projects/case_study/test_BKPT_sorted.vcf.gz"
tmp_name="/scratch1/jlee0087/projects/case_study/temp.vcf"
output_name="/scratch1/jlee0087/projects/case_study/filtered.test_BKPT_sorted.vcf"
snpeffpath="/project/davidwcr_264/Packages/snpEff_new/4.3/"
dbnsfpath="/scratch1/jlee0087/projects/exome_exercise/dbnsfp/dbNSFP4.1a.txt.gz"

###########################
# COMMANDS
###########################
## MT CHROMOSOME ONLY
bcftools view -r MT ${input_vcf} > ${tmp_name}


## QUALITY FILTER STEP
bcftools view -i 'QUAL >= 500' ${tmp_name} > ${tmp_name}


## HIGH IMPACT STEP
bcftools view -i 'INFO/ANN~"HIGH"' ${tmp_name} > ${tmp_name}

## SNPSIFT DBNSFP ANNOTATION STEP

java  -Xmx16g -jar ${snpeffpath}/SnpSift.jar dbnsfp -db ${dbnsfpath} ${tmp_name} > ${tmp_name}


## POP AF < 0.001

bcftools view -i 'INFO/dbNSFP_1000Gp3_AF < 0.001' ${tmp_name} > ${tmp_name}

## CANONICAL

java -Xmx16g -jar $snpeffpath/snpEff.jar -canon GRCh37.75 ${tmp_name} > ${output_name}



#rm ${tmp_name}





