# broccoli_ortho_files

Bash scripts to make single-copy orthologue fasta files ready for phylogenomics from [**Broccoli**](https://github.com/rderelle/Broccoli) output.

Designed to be run within the same directory as a Broccoli run as:

```
./orthogroup_fasta_array_submit.sh -i /path/to/genesets/dir
```

Which will submit a Univa-Grid-Engine cluster array job `orthogroup_fasta_array.sh`