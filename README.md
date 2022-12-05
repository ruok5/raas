# Reva as a Service, aka RaaS

## Why?
We have been running Reva as an `irssi` script for a long time. Since it's messy to maintain an `irssi` instance "in the cloud", this project aims to re-form Reva as a simple web service. This would permit consumption of responses in venues other than plain IRC, as well as allow other parties to create mash-ups.

## How?
You tell me. Is there something more than initializing a git repo?
### Stuff that didn't work so good for me
* Doing the webserver in Perl's `HTTP::Server::Simple::CGI`. Just too fiddly and I broke up with Perl for a reason.

## What?

For now, [the bot is operated](https://metacpan.org/pod/distribution/Hailo/bin/hailo) like so:

### Getting a random reply
```
hailo -b /app/db/reva.sqlite -R
```
### Getting a reply to `STRING`
```
hailo -b /app/db/reva.sqlite -r STRING
```
### Allow learning and get a reply to `STRING`
```
hailo -b /app/db/reva.sqlite -L STRING
```
