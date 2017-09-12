#usr/bin/perl

$file=$ARGV[0];
open(FILE,"<$file");
@lines=<FILE>;
close FILE;
$single=join('',@lines);
$single=~s/A\n/A/g;
$single=~s/T\n/T/g;
$single=~s/G\n/G/g;
$single=~s/C\n/C/g;
$single=~s/>/\n>/g;
@fastas=split(/>/,$single);
shift @fastas;
($file,$ext)=split(/\./,$file,2);
foreach $fasta (@fastas){
	chomp $fasta;
	($head,$seq)=split(/\n/,$fasta,2);
	$length=length $seq;
	if ($length>=150){
		open(OUTFILE,">>$file.filtered.$ext");
		print OUTFILE ">$head\n$seq\n";
		close OUTFILE;
	}
}
