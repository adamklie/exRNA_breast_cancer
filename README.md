# CSE283 - Cancer prediction with extracellular (exRNA) in serum

## Requirements (TODO)
conda installation
requirements.txt

## Dataset
SILVER-seq on 128 serum samples from healthy and cancer (recurrent and non-recurrent) patients.

Linked publication:
[Zixu Zhou, et al., Extracellular RNA in a single droplet of human serum reflects physiologic and disease states. 
PNAS, 2019, 116:19200–19208.](https://www.pnas.org/content/116/38/19200)

Linked accessions:
GEO - [GSE131512](https://www.ncbi.nlm.nih.gov//geo/query/acc.cgi?acc=GSE131512)
SRA - [SRP198979](https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP198979)
BioProject - [PRJNA543872](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA543872)

## Download raw fastq
1. Get accession list (SRR_Acc_List.txt) and run table (SraRunTable.txt) from https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRP198979&o=acc_s%3Aa
2. Pull out non-index fastq accessions SraRunTable using `process_metadata.ipynb` (SRR_Acc_List_NonIndex.txt)
3. Downloaded fastqs using `download_data.sh`
 - requires `fastq-dump` from sra-toolkit (conda install -c bioconda sra-tools)
 
## Align fastq to GRCh38
1. Download reference genome from [Illumina iGenomes](https://support.illumina.com/sequencing/sequencing_software/igenome.html):
 - `wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/NCBI/GRCh38/Homo_sapiens_NCBI_GRCh38.tar.gz`
2. Run bwa.sh to align  to GRCh38 and pull out unmapped reads
 - Use [bwa mem] to align (conda install -c bioconda bwa)
 - Use [samtools] to pull out unmapped reads (conda install -c samtools)

## Classify unmapped sequences
1. Install [kraken2](https://ccb.jhu.edu/software/kraken2/index.shtml?t=manual) (conda install -c bioconda kraken2)
2. Download [MiniKraken2_v1_8GB](https://ccb.jhu.edu/software/kraken2/index.shtml?t=downloads) database (no build required)
 - `wget ftp://ftp.ccb.jhu.edu/pub/data/kraken2_dbs/old/minikraken2_v1_8GB_201904.tgz`
3. Run kraken2.sh to classify unmapped sequences

## Analyze feature table using Qiime2
1. Create qiime environment (https://docs.qiime2.org/2020.2/install/native/#install-miniconda)
2. Step through qiime_analysis.ipynb to move data into qiime
 - Generate sample_metadata.tsv using `process_metadata.ipynb`

## Sample classification

### Qiime2
https://docs.qiime2.org/2019.10/plugins/available/sample-classifier/
https://docs.qiime2.org/2020.2/tutorials/sample-classifier/
Run `qiime_analysis.ipynb` to perform sample classification using Qiime plugin

### TODO: Other classification techniques

## Other

