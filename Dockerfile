FROM ruby:2.4.5

MAINTAINER Robert JJ Smith <rsmithlal@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libssl-dev

RUN mkdir /joatu
WORKDIR /joatu
COPY Gemfile /joatu/Gemfile
COPY Gemfile.lock /joatu/Gemfile.lock

# Use a persistent volume for the gems installed by the bundler
ENV BUNDLE_GEMFILE=/joatu/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundler \
  GEM_PATH=/bundler \
  GEM_HOME=/bundler

RUN gem install bundler
RUN bundle install

COPY . /joatu