#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use Data::ICal;

my $calendar_url = "http://www.pogdesign.co.uk/cat/download_ics/2af7747583b17bb008bf5c5211305089";
my %shows = ();

while(<>){
  chomp;
  (my $name, my $quality) = split(/;/,$_);
  $shows{$name} = $quality;
} 


my $ua = LWP::UserAgent->new();
my $ical = $ua->get($calendar_url)->content;
my $entries = Data::ICal->new(data => $ical)->entries;
for my $entry (@{$entries}){
  my %properties = %{$entry->properties()};
  my $value = $properties{'categories'}[0]->value;
  $value =~ s/\s*(.+)\s+Episodes, TV Shows/$1/;
  $shows{$value} = '720p';
}

for my $show (keys %shows){
  print "$show;$shows{$show};\n";
}



