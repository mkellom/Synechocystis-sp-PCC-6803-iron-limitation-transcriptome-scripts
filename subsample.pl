#!usr/bin/perl
$fasta=$ARGV[0];
($name,$ext)=split(/\.([^\.]+)$/,$fasta,2);
$sample_size=$ARGV[1];
open(FILE,"<$fasta");
@fastas=<FILE>;
close FILE;
$fasta=join('',@fastas);
@fastas=split(/>/,$fasta);
shift @fastas;
$total_size=scalar @fastas;
$written="NULL";
for($i=1;$i<=$sample_size;$i++){
	$draw=int(rand($total_size));
	$fasta=$fastas[$draw];
	chomp $fasta;
	if ($written!~/$fasta;/){
		open(OUTFILE,">>$name.subsampled$sample_size.$ext");
		print OUTFILE ">$fasta\n";
		close OUTFILE;
		$written.="$fasta;"
	}else{
		redo;
	}
}
