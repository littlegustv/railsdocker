FROM ruby:2.2.3-slim

MAINTAINER Benny Heller <hellerb@upenn.edu>

RUN apt-get update -qq
RUN apt-get install -qq -y build-essential patch ruby-dev zlib1g-dev liblzma-dev libmysqlclient-dev nodejs

# sets up the directory for the app, I guess
ENV INSTALL_PATH /RailsDocker
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# uses the Gemfile from our current folder
COPY Gemfile Gemfile
# This wasn't in the first example I saw, but it is in another... consider?
# COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

RUN bundle exec rake assets:precompile --trace
# ...

# RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

# ??

# VOLUME ["$INSTALL_PATH/public"]

CMD bundle exec rails s -b 0.0.0.0 -p 8080
CMD bundle exec rails db:migrate RAILS_ENV=development

# EXPOSE 8080