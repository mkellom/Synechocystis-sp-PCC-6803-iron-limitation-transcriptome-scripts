#!usr/bin/perl

$genes_file=$ARGV[0]; #or skews file
$tiles_file1=$ARGV[1];
$tiles_file2=$ARGV[2];
open(FILE,"<$genes_file");
@genes=<FILE>;
close FILE;
open(FILE,"<$tiles_file1");
@tiles1=<FILE>;
close FILE;
open(FILE,"<$tiles_file2");
@tiles2=<FILE>;
close FILE;
@tiles=(@tiles1,@tiles2);
foreach $gene (@genes){
	($kary1,$gene_start,$gene_stop,$grey)=split(/ /,$gene,4);
	$C1=0;
	$C2=0;
	$C3=0;
	$F1=0;
	$F2=0;
	$F3=0;
	foreach $tile (@tiles){
		($kary2,$tile_start,$tile_stop,$color)=split(/ /,$tile,4);
		if ($gene_start>=$tile_start && $gene_start<=$tile_stop){
			if ($color=~/178,24,43/){
				$F1++;
			}elsif ($color=~/214,96,77/){
				$F2++;
			}elsif ($color=~/244,165,130/){
				$F3++;
			}elsif ($color=~/33,102,172/){
				$C1++;
			}elsif ($color=~/67,147,195/){
				$C2++;
			}elsif ($color=~/146,197,222/){
				$C3++;
			}
			next;
		}elsif ($gene_stop>=$tile_start && $gene_stop<=$tile_stop){
			if ($color=~/178,24,43/){
				$F1++;
			}elsif ($color=~/214,96,77/){
				$F2++;
			}elsif ($color=~/244,165,130/){
				$F3++;
			}elsif ($color=~/33,102,172/){
				$C1++;
			}elsif ($color=~/67,147,195/){
				$C2++;
			}elsif ($color=~/146,197,222/){
				$C3++;
			}
			next;
		}elsif ($gene_start<=$tile_start && $gene_stop>=$tile_stop){
			if ($color=~/178,24,43/){
				$F1++;
			}elsif ($color=~/214,96,77/){
				$F2++;
			}elsif ($color=~/244,165,130/){
				$F3++;
			}elsif ($color=~/33,102,172/){
				$C1++;
			}elsif ($color=~/67,147,195/){
				$C2++;
			}elsif ($color=~/146,197,222/){
				$C3++;
			}
			next;
		}
	}
	$complete=$C1+$C2+$C3;
	$fe_lim=$F1+$F2+$F3;
	$c_avg=$complete/3;
	$f_avg=$fe_lim/3;
	open(OUTFILE,">>$kary1.counts.txt");
	print OUTFILE "$gene_start\t$gene_stop\t$fe_lim\t$complete\t$f_avg\t$c_avg\t$F1\t$F2\t$F3\t$C1\t$C2\t$C3\n";
	close OUTFILE;
}
