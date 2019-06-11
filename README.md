# Reva as a Service, aka RaaS

## Why?
We have been running Reva as an `irssi` script for a long time. Since it's messy to maintain an `irssi` instance "in the cloud", this project aims to re-form Reva as a simple web service. This would permit consumption of responses in venues other than plain IRC, as well as allow other parties to create mash-ups.

## How?
You tell me. Is there something more than initializing a git repo?
### Stuff that didn't work so good for me
* Doing the webserver in Perl's `HTTP::Server::Simple::CGI`. Just too fiddly and I broke up with Perl for a reason.