#!/usr/bin/perl

use Bio::Seq;
use Bio::SeqIO;
use List::Util qw( min max );
use File::Basename;

$filename=$ARGV[0];
@name =split("\\.",basename($filename));


open(FH1,">","$name[0]_length_of_each_seq.txt");
open(FH2,">","$name[0]_seq_len_distribution.txt");

$seqin=Bio::SeqIO->new(-file => $filename);

while(($seqobj=$seqin->next_seq()))
{
$header=$seqobj->display_id();
$sequence=$seqobj->seq();
$len=length$sequence;
print FH1 $header."\t".$len."\n";

push(@len_arr,$len);
}

close FH1;

for($i=0;$i<=max(@len_arr)+300;$i+=200)
{ push(@range, $i); }

foreach $num(@len_arr)
{
 for($j=0;$j<=@range;$j++)
 {
 if($num>=$range[$j] && $num<$range[$j+1])
  {
  $my_range=$range[$j]."-".$range[$j+1];
  $cnt{$my_range}++;
  }
 }
}

foreach $key ( keys %cnt )
{
  print FH2 $key."\t".$cnt{$key}."\n";
}

