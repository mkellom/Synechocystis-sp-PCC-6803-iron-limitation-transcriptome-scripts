#!usr/bin/perl

$input = $ARGV[0];
$output = $ARGV[1];

use Bio::SearchIO; 
$in = new Bio::SearchIO(-format => 'blast', 
                           -file   => $input);
while( $result = $in->next_result ) {
	## $result is a Bio::Search::Result::ResultI compliant object
	while( $hit = $result->next_hit ) {
		## $hit is a Bio::Search::Hit::HitI compliant object
		while ( $hsp = $hit->next_hsp ) {
		open(OUTFILE, ">>$output");
		print OUTFILE
		$result->query_name,
		" ", $hsp->start('query'),
		"-", $hsp->end('query'),
		" ; ", $hit->name,
		" ", $hsp->start('hit'),
		"-", $hsp->end('hit'),
		" ", $hsp->percent_identity,
		"% ", $hsp->evalue,
		"\n";
		close OUTFILE;
		}
	}
}
