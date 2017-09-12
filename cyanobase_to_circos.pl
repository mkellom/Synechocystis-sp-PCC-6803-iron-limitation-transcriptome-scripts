#!usr/bin/perl

$ptt=$ARGV[0];
open(FILE,"<$ptt");
@lines=<FILE>;
close FILE;
shift @lines;
shift @lines;
shift @lines;
($file,$ext)=split(/\./,$ptt,2);
@colors=("0","0.5","1");
foreach $line (@lines){
	@parts=split(/\t/,$line);
	$start=$parts[0];
	$stop=$parts[1];
	$start--;
	$color=shift @colors;
	open(OUTFILE,">>$file.genome.txt");
	print OUTFILE "$file.1 $start $stop $color\n";
	close OUTFILE;
	push(@colors,$color);
}
