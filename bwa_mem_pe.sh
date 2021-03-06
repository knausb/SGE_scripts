#!/bin/bash
#$ -cwd
#$ -S /bin/bash
#$ -N pe
#$ -o bwa0out
#$ -e bwa0err
#$ -q !gbs
# #$ -l mem_free=10G
#$ -V
# #$ -h
# #$ -t 1-3:1
# #$ -t 4-4:1
#$ -t 1-16:1
# #$ -t 17-17:1

i=$(expr $SGE_TASK_ID - 1)

PATH=~/bin/samtools-1.1:$PATH

echo "Path:"
echo $PATH
echo ""

REF="/home/bpp/knausb/Grunwald_Lab/home/knausb/pinf_bwa/bwaref/pinf_super_contigs.fa"

FILE=( `cat "samples.txt" `)

IFS=';' read -a arr <<< "${FILE[$i]}"

echo "${arr[1]}"

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date

#~/bin/bwa-0.7.10/bwa mem -R '@RG\tID:'${NAMES[$i]}'\tSM:'${NAMES[$i]} $REF ${FWD[$i]} ${REV[$i]} > 'sams/'${NAMES[$i]}'.sam'
#/home/bpp/knausb/bin/bwa-0.7.10/bwa mem -M -R '@RG\tID:'${arr[0]}'\tSM:'${arr[0]} $REF ${arr[1]} ${arr[2]} > 'sams/'${arr[0]}'.sam' 

date

# Echo samtools version info.
samtools --version

CMD="samtools view -bSu sams/${arr[0]}.sam | samtools sort -n -O bam -T bams/${arr[0]}_samtools_nsort_tmp | samtools fixmate /dev/stdin bams/${arr[0]}.fmsorted.bam"
echo $CMD
eval $CMD


CMD="samtools sort -O bam -T bams/${arr[0]}_samtools_csort_tmp -o bams/${arr[0]}_csort.bam bams/${arr[0]}.fmsorted.bam"
#CMD="samtools sort -O bam -T bams/${arr[0]}_samtools_csort_tmp bams/${arr[0]}.fmsorted.bam > bams/${arr[0]}_csort.bam"
echo $CMD
eval $CMD


echo "Samtools done"

date
