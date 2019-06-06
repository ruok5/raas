FROM perl:5.30

MAINTAINER brad@fyvm.org

# this layer is expensive when building.
# leave it alone for now so we don't have to redo it.
# other cpanm steps can be combined once we stabilize the cpan deps.
RUN cpanm AVAR/Hailo-0.75.tar.gz

# merge this into the previous layer later on
RUN cpanm BPS/HTTP-Server-Simple-0.52.tar.gz

ADD app /app

CMD ["/usr/local/bin/perl", "/app/reva-server.pl"]