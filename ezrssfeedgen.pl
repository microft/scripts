#!/usr/bin/perl
#
#
use strict;
use warnings;
use XML::FeedPP;
my $feed = XML::FeedPP::RSS->new();
my $search_url = 'http://ezrss.it/search/index.php?show_name=NAME&date=&quality=QUALITY&release_group=&mode=rss';
while(<>){
  chomp;
  (my $name, my $quality) = split(/;/,$_);
  $name =~ s/\s+/+/g;
  my $url = $search_url;
  $url =~ s/NAME/$name/;
  $url =~ s/QUALITY/$quality/;
  $feed->merge($url);
  #print $url;
}
my $now = time();
$feed->pubDate( $now );    
print $feed->to_string();
