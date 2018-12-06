FROM ruby:2.3.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libssl-dev
RUN mkdir /joatu
WORKDIR /joatu
COPY Gemfile /joatu/Gemfile
COPY Gemfile.lock /joatu/Gemfile.lock
# Use a persistent volume for the gems installed by the bundler
ENV BUNDLE_PATH /bundler
RUN gem install bundler
RUN gem install puma -v '2.11.0' --source 'https://rubygems.org/'
RUN bundle install
COPY . /joatu