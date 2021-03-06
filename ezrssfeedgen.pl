#!/usr/bin/perl
#
# This scripts expects a csv file in the format Show Name;Quality
# and merges all the resulting RSS feeds from ezrss.it
#
# Example:
# Burn Notice;720p
# IT Crowd;PDTV
# 
# Should be called like this:
# /usr/bin/perl ezrssfeedgen.pl tvshows.csv > tvshows.xml
#
use strict;
use warnings;
use XML::FeedPP;
my $feed = XML::FeedPP::RSS->new();
my $search_url = 'http://ezrss.it/search/index.php?simple&show_name=NAME&date=&quality=QUALITY&release_group=&mode=rss';
while(<>){
  chomp;
  (my $name, my $quality, my $extra) = split(/;/,$_);
  $name =~ s/[\#\!\*\$]/ /g;
  $name =~ s/(^\s+|\s+$)//g;
  #$name =~ s/\s+$//g;
  $name =~ s/\s+/+/g;
  my $url = $search_url;
  $url =~ s/NAME/$name/;
  $url =~ s/QUALITY/$quality/;
  if ($extra) {
      $url .= $extra;
  }
  #print $url ,"\n";
  $feed->merge($url);
}
my $hostname = `hostname -f`;
chomp($hostname);
$feed->title("$hostname TV Shows");
$feed->limit_item(25);
my $now = time();
$feed->pubDate( $now );    
print $feed->to_string();
