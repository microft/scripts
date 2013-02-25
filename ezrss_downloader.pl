#!/usr/bin/perl
#
use strict;
use warnings;
use Data::Dumper;
use XML::FeedPP;
use DBI;

my $url = "http://uk.microft.org/files/tvshows.xml";
my $feed = XML::FeedPP::RSS->new( $url );
my $dbh = DBI->connect( "dbi:SQLite:dbname=/tmp/downloads.db","","", { RaiseError => 1, AutoCommit => 1 });
my $create_query = "create table if not exists downloaded_torrents (filename TEXT);";
$dbh->do($create_query);


while (<>){
    chomp;
    (my $name, my $quality, undef) = split(/;/,$_);
    my @matched = $feed->match_item( 'title' => qr/\b$name\b/i );
    for my $match (@matched) {
        my $link;
        if ( $quality and $match->{'title'} =~ m/$quality/i ) {
            $link = $match->{'link'};
        } elsif ( not $quality ) {
            $link = $match->{'link'};
        }
        if ($link) {
            my $filename = $link;
            $filename =~ s!.*/([^/]+.torrent)!$1!;
            #print Dumper($filename);
            my $downloaded = $dbh->selectall_arrayref("SELECT filename from downloaded_torrents WHERE filename = '$filename' ;");
            #print Dumper($downloaded);
            my $command = "wget -q -c -P ~/Dropbox/torrents/ \"$link\" ";
            my $result = system($command) unless scalar @$downloaded;
            $dbh->do("INSERT INTO downloaded_torrents VALUES ('$filename');") unless scalar @$downloaded;
        }
    }
}

$dbh->commit();
$dbh->disconnect;
