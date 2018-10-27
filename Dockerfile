FROM darthjee/ruby_plot:0.0.1

RUN bundle install --clean

USER app
