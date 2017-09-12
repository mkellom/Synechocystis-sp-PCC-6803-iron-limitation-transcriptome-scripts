#!usr/bin/perl

$mapkey=$ARGV[0];
open(FILE,"<$mapkey");
@keys=<FILE>;
close FILE;
foreach $key (@keys){
	chomp $key;
	@parts=split(/ /,$key);
	$id=$parts[5];
	$id=~s/%//;
	if ($id>=90){
		$read=$parts[0];
		($group,$read)=split(/_/,$read,2);
		if ($group=~/Syn2/){
			$color="(178,24,43)";
			$order=1;
		}elsif ($group=~/Syn5/){
			$color="(214,96,77)";
			$order=1;
		}elsif ($group=~/Syn7/){
			$color="(244,165,130)";
			$order=1;
		}elsif ($group=~/Syn4/){
			$color="(33,102,172)";
			$order=2;
		}elsif ($group=~/Syn11/){
			$color="(67,147,195)";
			$order=2;
		}elsif ($group=~/Syn12/){
			$color="(146,197,222)";
			$order=2;
		}
		$genome=$parts[3];
		@refs=split(/\|/,$genome);
		$genome=$refs[3];
		$location=$parts[4];
		($start,$stop)=split(/-/,$location,2);
		$map{$genome}{$order}.="$genome $start $stop color=$color\n";
	}
}
foreach $order (sort{$a<=>$b}keys $map{$genome}){
	foreach $genome (keys %map){
		open(OUTFILE,">>$genome.circos$order.txt");
		print OUTFILE $map{$genome}{$order};
		close OUTFILE;
	}
}
