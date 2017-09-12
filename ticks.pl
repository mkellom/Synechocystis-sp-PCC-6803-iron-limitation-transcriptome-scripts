#!usr/bin/perl
$outfile=$ARGV[0];
$genome_length=$ARGV[1];
for($i=0;$i<=$genome_length;$i+=100000){
	open(OUTFILE,">>$outfile.ticks.txt");
	print OUTFILE "$outfile $i $i 1\n";
	close OUTFILE;
}
