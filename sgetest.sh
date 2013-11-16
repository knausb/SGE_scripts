#!/bin/bash

#$ -cwd
#$ -S /bin/bash
#$ -N sgetest
#$ -o testout
#$ -e testerr
#$ -l mem_free=10G
#$ -V
# #$ -h
#$ -t 1-3:1

i=$(expr $SGE_TASK_ID - 1)

PATH=$PATH:~/bin/

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date

echo "This is a test."
sleep 30
date

# EOF.
