#!/usr/bin/perl

use strict;
use warnings;

{
package RevaApi;
 
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);
 
my %dispatch = (
    '/api/v1/reply' => \&resp_reply,
    '/api/v1/train' => \&resp_train,
    '/api/v1/stats' => \&resp_stats
);
 
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
 
sub resp_reply {
    my $cgi  = shift;   # CGI.pm object
    return if !ref $cgi;
     
    my $query_string = $cgi->param('q');

    my $bot_response = `/usr/local/bin/hailo --brain /app/db/reva.sqlite -r $query_string`;
     
    print $cgi->header,
          $cgi->start_html("Hello"),
          $cgi->h1("$bot_response"),
          $cgi->end_html;
}

sub resp_train {
  # body...
}

sub resp_stats {
  print ".\n";
}
 
} 
 
# start the server on port 3000
my $pid = RevaApi->new(3000)->run();
print "Use 'kill $pid' to stop server.\n";