FROM darthjee/taap:0.0.3

WORKDIR /home/app/urna/
ADD Gemfile* /home/app/urna/

USER root
RUN bundle install --clean

USER app
