#!/usr/bin/perl

use strict;
use warnings;

{
package RevaApi;
 
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);
use Encode;
use JSON;
use CGI::Log;
 
my %dispatch = (
    '/live/reply' => \&resp_live_reply,
    '/api/v1/reply' => \&resp_api_reply,
    '/api/v1/train' => \&resp_api_train,
    '/api/v1/stats' => \&resp_api_stats
);

sub get_data {
  my $query = shift;

  unless (defined($query)) {
    $query = "";
  }

  # random reply mode will be default
  my $mode = "R";

  # strip leading and trailing whitespace
  $query =~ s/^\s+|\s+$//g;

  # reply to query if we have one
  unless ($query eq "") {
    $mode = "r";
  }

  my $bot_response = qx{/usr/local/bin/hailo --brain /app/db/reva.sqlite -$mode '$query'};

  Log->status("query contains $query");

  return $bot_response;
}
 
sub handle_request {
    my $self = shift;
    my $cgi  = shift;
   
    my $path = $cgi->path_info();
    my $handler = $dispatch{$path};
 
    if (ref($handler) eq "CODE") {
        print "HTTP/1.0 200 OK\r\n";
        $handler->($cgi);
         
    } else {
        print "HTTP/1.0 404 Not found\r\n";
        print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
    }
}
 
sub resp_live_reply {
    my $cgi  = shift;   # CGI.pm object
    return if !ref $cgi;
     
    my $query_string = decode utf8=>$cgi->param('q');
     
    print $cgi->header,
          $cgi->start_html();

    print qq(<br><form action="/live/reply" method="get"><input type="text" name="q" autofocus>\n);
     
    print $cgi->h1(get_data($query_string)),
          $cgi->end_html;
}

sub resp_api_reply {
  # body...
}

sub resp_api_train {
  # body...
}

sub resp_api_stats {
  # body...
}
 
} 
 
# start the server in the foreground on port 3000
my $pid = RevaApi->new(3000)->run();