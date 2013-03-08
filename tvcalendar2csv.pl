#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use Data::ICal;

my $calendar_url = "http://www.pogdesign.co.uk/cat/download_ics/2af7747583b17bb008bf5c5211305089";
my %shows = ();


my $ua = LWP::UserAgent->new();
my $ical = $ua->get($calendar_url)->content;
my $entries = Data::ICal->new(data => $ical)->entries;
for my $entry (@{$entries}){
  my %properties = %{$entry->properties()};
  my $value = $properties{'categories'}[0]->value;
  $value =~ s/\s*(.+)\s+Episodes, TV Shows/$1/;
  $value =~ s/\://g;
  $shows{$value} = '720p';
}

# input CSV file overides online calendar
while(<>){
  chomp;
  (my $name, my $quality) = split(/;/,$_);
  $shows{$name} = $quality;
} 

for my $k (keys %shows){
  my $show = $k;
  $show =~ s/The//gi;
  print "$show;$shows{$k};\n";
}



