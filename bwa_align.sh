#!/bin/sh
########################
# SLURM
########################
#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=8:00:00
########################
#  Variables
#########################
resourceDir="/scratch1/jlee0087/resources/b37"
outputDir="/scratch1/jlee0087/projects/exome_exercise/bams"
logDir="/scratch1/jlee0087/projects/exome_exercise/genome/logs/"
outPrefix="NA12878"
fq1_r1="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L001_R1_001.fastq.gz"
fq1_r2="/scratch1/jlee0087/projects/exome_exercise/genome/fastqs/NIST7035_TAAGGCGA_L001_R2_001.fastq.gz"
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
if [ -f ${resourceDir}/human_g1k_v37.fasta.gz ]; then
  bwa mem ${resourceDir}/human_g1k_v37.fasta.gz "<zcat ${fq1_r1}" "<zcat ${fq1_r2}" >>${outputDir}/${outPrefix}.l1.sam 2>> ${logDir}/bwa.l1.out 
else 
  echo $? "Failed to find index"
  exit 1 # Fail
fi
########################
#  BAMS, not SAMS
#########################
if [ -f ${outputDir}/${outPrefix}.l1.sam ]; then
  samtools fixmate -O bam ${outputDir}/${outPrefix}.l1.sam ${outputDir}/${outPrefix}.l1.bam >& ${logDir}/fix.thread1.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l1.sam"
fi
if [ -f ${outputDir}/${outPrefix}.l1.bam ]; then
  rm ${outputDir}/${outPrefix}.l1.sam
fi
########################
# Sort
#########################
if [ -f ${outputDir}/${outPrefix}.l1.bam ]; then
  samtools sort ${outputDir}/${outPrefix}.l1.bam >> ${outputDir}/${outPrefix}.l1.sort.bam 2>> ${logDir}/sort.thread1.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l1.bam"
fi
if [ -f ${outputDir}/${outPrefix}.l1.sort.bam ]; then
 rm ${outputDir}/${outPrefix}.l1.bam
fi
########################
#  Index
#########################
if [ -f ${outputDir}/${outPrefix}.l1.sort.bam ]; then
  samtools index ${outputDir}/${outPrefix}.l1.sort.bam >& ${logDir}/index.thread1.log
else 
   echo $? "Failed to find ${outputDir}/${outPrefix}.l1.sort.bam"
fi
 #echo "Reminder: Leaving at 4 PM today" | mail -s "early departure" myboss
