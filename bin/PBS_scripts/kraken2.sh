#!/bin/bash

### Specify the name of the job, output file, and error/log file;
#PBS -N kraken2
#PBS -o /home/aklie/doc/log/kraken2.$PBS_JOBID.log
#PBS -e /home/aklie/doc/err/kraken2.$PBS_JOBID.err

### Request resources for the job, and the walltime for the job to run
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -l mem=64gb

##### Exports all user environment variables to the job
#PBS -V

### Specify the email to recieve
#PBS -M aklie@eng.ucsd.edu
#PBS -m abe

BAMS=/home/aklie/scratch/exRNA_breast_cancer/bam/bams
FASTAS=/home/aklie/scratch/exRNA_breast_cancer/kraken/fasta
KRAKEN_DB=/home/aklie/scratch/exRNA_breast_cancer/kraken
KRAKEN=/home/aklie/scratch/exRNA_breast_cancer/kraken/kraken_out

start=$SECONDS
source activate utilities

# Convert bams to fastas
echo -e "Convert bams to fastas"
cd $BAMS
for i in *.unmapped.bam
do
    SAMPLE=$(echo $i | cut -d '.' -f 1,2)
    samtools fasta ${SAMPLE}.bam > ${FASTAS}/${SAMPLE}.fa
done

# Assign taxonomic classification
echo -e "Assign taxonomic classification"
cd $FASTAS
for i in *.fa
do
    SAMPLE=$(echo $i | cut -d '.' -f 1,2)
    kraken2 \
        --db ${KRAKEN_DB}/minikraken2_v1_8GB \
        --threads 16 \
        --report ${KRAKEN}/${SAMPLE}.kreport2 \
        ${SAMPLE}.fa \
        > ${KRAKEN}/${SAMPLE}.kraken2 
done

duration=$(( SECONDS - start ))
echo -e "\nTime elapsed: $duration"
