#!/bin/sh
#$ -cwd                 # Set the working directory for the job to the current directory
#$ -pe smp 1            # Request 1 core
#$ -l h_rt=00:01:00     # Request 1 hour runtime
#$ -l h_vmem=1G         # Request 1GB RAM
#$ -o /dev/null         # Suppress stdout to file (as large array job)
#$ -e /dev/null         # Suppress sterr to file (as large array job)
#$ -t 1-244             # Set array number (i.e. number of orthogroups to run/length of 'list' file)

#Make variable with the orthogroup number
ORTHOGROUP=$(cat list | sed -n ${SGE_TASK_ID}p | awk '{print $1}')

#Produce temp file of protein IDs in orthogroup
grep -w "${ORTHOGROUP}" dir_step3/orthologous_groups.txt | awk '{for(i=2;i<=NF;++i)print $i}' > orthogroup_sequences/${ORTHOGROUP}_proteins
#Search list of protein IDs against all proteins sets
awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' orthogroup_sequences/${ORTHOGROUP}_proteins orthogroup_sequences/tmp > orthogroup_sequences/${ORTHOGROUP}.fa
#Remove protein_IDs temp file
rm orthogroup_sequences/${ORTHOGROUP}_proteins
