#!usr/bin/perl
$counts_file=$ARGV[0];
$et_file=$ARGV[1];
($file,$ext)=split(/\./,$counts_file,2);
print "Opening counts file\n";
open(FILE,"<$counts_file");
@counts=<FILE>;
close FILE;
print "Opening exact test file\n";
open(FILE,"<$et_file");
@ets=<FILE>;
close FILE;
shift @ets;
print "Calculating Bin Responses and log2 Fold Changes\n";
$min=999999;
$max=-999999;
open(OUTFILE,">>$file.1.master.txt");
print OUTFILE "Product\tCode\tStart\tStop\tStrand\tComplete1\tComplete2\tComplete3\tFe-limitation1\tFe-limitation2\tFe-limitation3\tComplete_mean\tFe-limitation_mean\tComplete_Var\tFe-limitation_Var\tLog2_fold_change\tedgeR_log2_fold_change\tBin_response\tT-statistic\tp-value\n";
close OUTFILE;
open(OUTFILE,">>$file.1.sigs.txt");
print OUTFILE "Product\tCode\tStart\tStop\tStrand\tComplete1\tComplete2\tComplete3\tFe-limitation1\tFe-limitation2\tFe-limitation3\tComplete_mean\tFe-limitation_mean\tComplete_Var\tFe-limitation_Var\tLog2_fold_change\tedgeR_log2_fold_change\tBin_response\tT-statistic\tp-value\n";
close OUTFILE;
foreach $count (@counts){
	chomp $count;
	($product,$code,$start,$stop,$strand,$c1,$c2,$c3,$fe1,$fe2,$fe3)=split(/\t/,$count,11);
	$fe_mean=(($fe1+$fe2+$fe3)/3)+1;
	$c_mean=(($c1+$c2+$c3)/3)+1;
	$bin_response=sprintf '%.3f', ((log(($fe_mean)/($c_mean)))/(log(10)));
	$fold_change=sprintf '%.3f', ((log(($fe_mean)/($c_mean)))/(log(2)));
	$fe_var=((($fe1-$fe_mean)**2)+(($fe2-$fe_mean)**2)+(($fe3-$fe_mean)**2))/3;
	$c_var=((($c1-$c_mean)**2)+(($c2-$c_mean)**2)+(($c3-$c_mean)**2))/3;
	$t_stat=(abs($fe_mean-$c_mean))/(sqrt(((($fe_var**2)/3)+(($c_var**2)/3))));
	if ($bin_response>=$max){
		$max=$bin_response;
	}
	if ($bin_response<=$min){
		$min=$bin_response;
	}
	open(OUTFILE,">>$file.1.skew.txt");
	print OUTFILE "$file.1 $start $stop $bin_response\n";
	close OUTFILE;
	foreach $et (@ets){
		chomp $et;
		($rowname,$logFC,$logCPM,$PValue,$FDR)=split(/\t/,$et,5);
		$rowname=~s/\"//g;
		if ($rowname eq $code){
			if (($PValue>0.05) or ($t_stat<2.776)){
				open(OUTFILE,">>$file.1.tests.txt");
				print OUTFILE "$file.1 $start $stop 0\n";
				close OUTFILE;
			}else{
				open(OUTFILE,">>$file.1.sigs.txt");
				print OUTFILE "$product\t$code\t$start\t$stop\t$strand\t$c1\t$c2\t$c3\t$fe1\t$fe2\t$fe3\t$c_mean\t$fe_mean\t$c_var\t$fe_var\t$fold_change\t$logFC\t$bin_response\t$t_stat\t$PValue\n";
				close OUTFILE;
			}
			last;
		}
	}
	open(OUTFILE,">>$file.1.master.txt");
	print OUTFILE "$product\t$code\t$start\t$stop\t$strand\t$c1\t$c2\t$c3\t$fe1\t$fe2\t$fe3\t$c_mean\t$fe_mean\t$c_var\t$fe_var\t$fold_change\t$logFC\t$bin_response\t$t_stat\t$PValue\n";
	close OUTFILE;
}
open(OUTFILE,">>$file.1.skew.txt");
print OUTFILE "$file.1 0 0 $min\n";
print OUTFILE "$file.1 0 0 $max\n";
close OUTFILE;
