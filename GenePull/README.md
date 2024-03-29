# GenePull

Tool to extract a certain gene from an assembly.

## Requirements

GenePull is an interactive bash script which runs in the linux command line. To download, simply use:

```
wget https://raw.githubusercontent.com/Rowena-h/MiscGenomicsTools/main/GenePull/GenePull
```

Make the script executable with:

```
chmod +x GenePull
```

[BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download) and [bedtools](https://bedtools.readthedocs.io/en/latest/) must be installed for the script to work.

## Usage

Option | Description
------ | -----------
-h, --help | Display these options
-a, --assembly | A genome assembly in fasta format
-g, --gene | Gene of closely related species in fasta format
-o, --output | Prefix for output file

If there are multiple hits for the query gene, you will be shown the blast results and asked which hit you want to extract. To pick multiple hits, numbers must be separated by commas (e.g. `1,2,5,6,8`). Alternatively all hits can be extracted by typing `a`.

### Example

```
./GenePull -a assembly.fa -g LSU.fa -o LSU_result
```
