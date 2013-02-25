#!/usr/bin/perl
#
use strict;
use warnings;
use Data::Dumper;
use XML::FeedPP;
use DBI;



#my $url = "http://rss.thepiratebay.se/0"; # All 
#my $url = "http://rss.thepiratebay.se/205";  # TV Shows feed
my $url = "http://rss.thepiratebay.se/208";  # HighRes TV Shows feed

my $feed = XML::FeedPP::RSS->new( $url );
my $dbh = DBI->connect( "dbi:SQLite:dbname=/tmp/tpb_downloads.db","","", { RaiseError => 1, AutoCommit => 1 });
my $create_query = "create table if not exists downloaded_torrents (title TEXT, link TEXT);";
$dbh->do($create_query);

while (<>){
    chomp;
    (my $name, my $quality, undef) = split(/;/,$_);

    my @matched = $feed->match_item( 'title' => qr/\b$name\b/i );
    for my $match (@matched) {
        my $link;
        my $title = $match->{'title'};

        if ( $quality and $title =~ m/$quality/i ) {
            $link = $match->{'link'};
        } elsif ( not $quality ) {
            $link = $match->{'link'};
        }
        if ($link) {
            #my $filename = $link;
            #$filename =~ s!.*/([^/]+.torrent)!$1!;
            #print Dumper($filename);
            my $downloaded = $dbh->selectall_arrayref("SELECT * from downloaded_torrents WHERE link = '$link' OR title = '$title' ;");
            #print Dumper($downloaded);
            #my $command = "wget -q -c -P ~/Dropbox/torrents/ \"$link\" ";
            my $command = "echo \"$link\" >> ~/Dropbox/torrents/home.microft.org/magnetic.txt";
            my $result = system($command) unless scalar @$downloaded;
            $dbh->do("INSERT INTO downloaded_torrents VALUES ('$title', '$link');") unless scalar @$downloaded;
        }
    }
}

#$dbh->commit();
$dbh->disconnect;
