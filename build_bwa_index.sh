#!/bin/sh


#SBATCH --cpus-per-task=16
#SBATCH --exclusive
#SBATCH --mem=0GB
#SBATCH --time=8:00:00

DATADIR="/scratch1/jlee0087/resources/b37"
mkdir -p ${DATADIR}
######################################### #  
#Running Analysis 
######################################### 
module load gcc/11.3.0
module load bwa

echo Running Analysis echo Path is `pwd`
cd ${DATADIR}
bwa index ${DATADIR}/human_g1k_v37.fasta.gz
