#!/usr/bin/perl

use warnings;
use strict;

my $def='';
my $run = 0; 
my $count = 6;
my $defs = 0;

while(<>)
{
   if (/^[\s]+\*/ && ($count > 0))
   {
      $def .= $_;
      $run = 1;
      $count -= 1;
   }
   elsif(/^[\s]+\[[\d]{1,2}\]/)
   {
      if ("$def" ne '' && !(/wiki/))
      {
         chomp $def;
         print "$def \n\t- $1\n\n" if ($' =~ /^([\w\s\.\-]+)\//);
         $defs+=1;
         exit if ($defs > 3);
      }
      $count = 6;
      $def = '';
      $run = 0;
   }
   elsif (/^[\s\w\"]+/ && $run == 1 && $count > 0)
   {
      $def .= $_;
   }
   elsif (/^\s+(Did you mean:)[\s\[\]\d]+define:/)
   {
      print "$1 $'";
      exit;
   }
}
print "No definition found\n" if $defs == 0;
