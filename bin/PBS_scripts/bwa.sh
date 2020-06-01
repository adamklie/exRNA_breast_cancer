#!/bin/bash

### Specify the name of the job, output file, and error/log file;
#PBS -N bwa
#PBS -o /home/aklie/doc/log/bwa.$PBS_JOBID.log
#PBS -e /home/aklie/doc/err/bwa.$PBS_JOBID.err

### Request resources for the job, and the walltime for the job to run
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -l mem=64gb

##### Exports all user environment variables to the job
#PBS -V

### Specify the email to recieve
#PBS -M aklie@eng.ucsd.edu
#PBS -m abe

start=$SECONDS
source activate utilities
IN=/home/aklie/scratch/exRNA_breast_cancer/fastq/fqs
REF=/home/aklie/scratch/exRNA_breast_cancer/bam/GRCh38/Homo_sapiens/NCBI/GRCh38/Sequence/BWAIndex/genome.fa
OUT=/home/aklie/scratch/exRNA_breast_cancer/bam/bams
cd $IN

for i in *.fastq.gz 
do
    SAMPLE=$(echo $i | cut -d '.' -f 1)
    bwa mem -t 16 $REF $i | samtools view -bS - > ${OUT}/${SAMPLE}.bam
    samtools view -f4 -b ${OUT}/${SAMPLE}.bam > ${OUT}/${SAMPLE}.unmapped.bam
    samtools flagstat ${OUT}/${SAMPLE}.bam > ${OUT}/${SAMPLE}.stats
done

duration=$(( SECONDS - start ))
echo -e "\nTime elapsed: $duration"