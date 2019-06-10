FROM perl:5.30

MAINTAINER brad@fyvm.org

# this layer is expensive when building.
# leave it alone for now so we don't have to redo it.
# other cpanm steps can be combined once we stabilize the cpan deps.
RUN cpanm AVAR/Hailo-0.75.tar.gz

ADD app /app

# ruby environment
RUN useradd -ms /bin/sh ruby && echo "ruby\nruby" | passwd ruby
USER ruby
WORKDIR /home/ruby

# install ruby
RUN \
  echo "whoami: $(whoami)" && \
  env && \
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"\neval "$(rbenv init -)"' >> ~/.profile && \
  . ~/.profile && \
  mkdir -p "$(/home/ruby/.rbenv/bin/rbenv root)"/plugins && \
  git clone https://github.com/rbenv/ruby-build.git "$(/home/ruby/.rbenv/bin/rbenv root)"/plugins/ruby-build && \
  RUBY_CONFIGURE_OPTS=--disable-install-doc /home/ruby/.rbenv/bin/rbenv install 2.6.3 && \
  /home/ruby/.rbenv/bin/rbenv local 2.6.3 && \
  /home/ruby/.rbenv/shims/gem install -N  mixlib-shellout

CMD ["/usr/local/bin/perl", "/app/reva-api.pl"]
# ruby is at /home/ruby/.rbenv/shims/ruby