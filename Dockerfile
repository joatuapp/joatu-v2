FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libssl-dev

RUN mkdir /joatu
WORKDIR /joatu
COPY Gemfile /joatu/Gemfile
COPY Gemfile.lock /joatu/Gemfile.lock

RUN gem install bundler -v 2.0.2

COPY . /joatu