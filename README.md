# MiscGenomicsTools

## [broccoli_ortho_files](/broccoli_ortho_files)

Bash scripts to make single-copy orthologue fasta files ready for phylogenomics from [**Broccoli**](https://github.com/rderelle/Broccoli) output.

## [GenePull](/GenePull)

A bash tool which extracts a certain gene from an assembly using BLAST and bedtools.

## One(ish)-liners

### Convert leading or trailing gaps (`-`) in a fasta file to `?`.
```
awk '/^>/ {
  printf("\n%s\n",$0);next; 
  } {
  printf("%s",$0);
  } END {
  printf("\n");
  }' file.fasta | \
awk -F '[^-](.*[^-]|$)' '{
  s=$0;
  h=gsub(/./,"?",$1);
  t=gsub(/./,"?",$2);
  print $1 substr(s,h+1, length(s)-h-t) $2
  }' > file_edited.fasta
```
#### Result:
```
cat file.fasta
>test
-------------agtc-cgcatgaggatagctcgtagataaaa---------
>test2
-----atta--------------atttgacc--------tga-----------
>test3
ataaagctcggctaa-----------------------tggac----------

cat file_edited.fasta
>test
?????????????agtc-cgcatgaggatagctcgtagataaaa?????????
>test2
?????atta--------------atttgacc--------tga???????????
>test3
ataaagctcggctaa-----------------------tggac??????????
```
