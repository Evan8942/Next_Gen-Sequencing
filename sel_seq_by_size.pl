#!/usr/bin/perl

use Bio::Seq;
use Bio::SeqIO;
use File::Basename;

$filename=$ARGV[0];
@name =split("\\.",basename($filename));

$l=$ARGV[1];

open(FH1,">","$name[0]_$l.fa");

$seqin=Bio::SeqIO->new(-file => $filename);

while(($seqobj=$seqin->next_seq()))
{
$header=$seqobj->display_id();
$sequence=$seqobj->seq();
$len=length$sequence;
if($len>=$l)
{ print FH1 ">".$header."\n".$sequence."\n"; }
}
