#!/bin/sh
########################
# SLURM
########################
#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=24:00:00
########################
#  Variables
#########################
resourceDir="/scratch1/jlee0087/resources/b37"
outputDir="/scratch1/jlee0087/projects/exome_exercise/bams"
logDir="/scratch1/jlee0087/projects/exome_exercise/genome/logs/"
outPrefix="lane2.NA12878"
fq1_r1="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L001_R1_001.fastq.gz"
fq1_r2="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L001_R2_001.fastq.gz"
fq2_r1="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L002_R1_001.fastq.gz"
fq2_r2="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L002_R2_001.fastq.gz"

########################
#  Setup
#########################
mkdir -p ${outputDir} ${logDir}
cd ${outputDir}

module load gcc/11.3.0
module load samtools
module load bwa
# Alignmnet consists of 4 scripts - and we need to align 4 fastqs. Each can be done seperately, and then merged together.
#$
########################
#  Align Lanes
#########################
if [ -f ${resourceDir}/human_g1k_v37.fasta ]; then
  bwa mem ${resourceDir}/human_g1k_v37.fasta "<zcat ${fq2_r1}" "<zcat ${fq2_r2}" >>${outputDir}/${outPrefix}.l2.sam 2>> ${logDir}/bwa.l2.out 
else 
  echo $? "Failed to find index"
  exit 1 # Fail
fi
########################
#  BAMS, not SAMS
#########################
if [ -f ${outputDir}/${outPrefix}.l2.sam ]; then
  samtools fixmate -O bam ${outputDir}/${outPrefix}.l2.sam ${outputDir}/${outPrefix}.l2.bam >& ${logDir}/fix.thread2.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l2.sam"
fi
if [ -f ${outputDir}/${outPrefix}.l2.bam ]; then
  rm ${outputDir}/${outPrefix}.l2.sam
fi
########################
# Sort
#########################
if [ -f ${outputDir}/${outPrefix}.l2.bam ]; then
  samtools sort ${outputDir}/${outPrefix}.l2.bam >> ${outputDir}/${outPrefix}.l2.sort.bam 2>> ${logDir}/sort.thread2.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l2.bam"
fi
if [ -f ${outputDir}/${outPrefix}.l2.sort.bam ]; then
 rm ${outputDir}/${outPrefix}.l2.bam
fi
########################
#  Index
#########################
if [ -f ${outputDir}/${outPrefix}.l2.sort.bam ]; then
  samtools index ${outputDir}/${outPrefix}.l2.sort.bam >& ${logDir}/index.thread2.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l2.sort.bam"
fi
