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

  $value = sanitize($value);

  $shows{$value} = '720p';
}

# input CSV file overides online calendar
while(<>){
  chomp;
  (my $name, my $quality) = split(/;/,$_);
  $shows{$name} = $quality;
} 

for my $k (keys %shows){
  print "$k;$shows{$k};\n";
}


sub sanitize {
  my $name = shift;

  $name =~ s/\s*(.+)\s+Episodes, TV Shows/$1/;
  $name =~ s/\://g;
  $name =~ s/\bThe\b//gi;
  $name =~ s/^\s+//g;
  $name =~ s/\s+$//g;

  return $name;

}
