#!usr/bin/perl

$file=$ARGV[0];
open(FILE,"<$file");
@lines=<FILE>;
close FILE;
@rRNAs=grep{/ribosomal_RNA/}@lines;
open(OUTFILE,">>r_$file");
print OUTFILE @lines;
close OUTFILE;
