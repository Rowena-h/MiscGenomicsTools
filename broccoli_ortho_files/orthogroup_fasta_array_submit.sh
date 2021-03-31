display_usage() {
	echo ""
	echo "USAGE: $0 [OPTIONS]"
    echo ""
	echo "OPTIONS"
    echo "  -i, --input"
    echo "      Path to directory containing the gene set fasta files which were used as input for the Broccoli run (must have .faa extension)"
    echo ""
    echo "EXAMPLE"
	echo "  $0 -i /data/genesets"
    echo ""
    exit
}

if [ -z "$1" ]
then
    display_usage
    exit
fi

while [ "$#" -gt 0 ]
do
    ARGUMENTS="$1"
    case $ARGUMENTS in
        -h|--help)
        display_usage
        ;;
        -i|--input)
        DIRECTORY="$2"
        shift
    esac
    shift
done

if [ -z "$DIRECTORY" ]
then
    echo ""
    echo "Missing required options"
    display_usage
    echo ""
    echo "Exiting..."
    exit
fi

mkdir orthogroup_sequences

#Print all gene sets for all samples into temp file (requires no duplicate gene names between samples)
cat ${DIRECTORY}/*.faa | sed 's/ .*//' > orthogroup_sequences/tmp

#Make list of orthogroups
cat dir_step3/orthologous_groups.txt | awk '{print $1}' | sed 1d > orthogroups
#Make list of orthogroups that need to be run (don't exist from previous run)
ls orthogroup_sequences/*.fa | sed 's/orthogroup_sequences\///' | sed 's/.fa//' > files
diff -y --suppress-common-lines <(sort orthogroups) <(sort files) | sed 's/<//' > list

#Read number of orthogroups to be run into variable for array jobs
NUM=$(cat list | wc -l)

#Submit cluster array jobs and wait until all have finished
qsub -t 1-${NUM} orthogroup_fasta_array.sh

sleep 2

while [[ `qstat | awk '$3 ~ "orthogroup"'` ]]
do
    sleep 3
    echo "`qstat | awk '$3 ~ "orthogroup"' | wc -l` running"
done

#Remake list of orthogroups that need to be run to check if all succeeded
ls orthogroup_sequences/*.fa | sed 's/orthogroup_sequences\///' | sed 's/.fa//' > files
diff -y --suppress-common-lines <(sort orthogroups) <(sort files) | sed 's/<//' > list

#Remove temp files
rm orthogroup_sequences/tmp
rm files
rm orthogroups
