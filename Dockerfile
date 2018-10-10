FROM ruby:2.5.1-slim

WORKDIR /opt/meeemories

RUN apt-get -qq update && \
    apt-get -qq --no-install-recommends install \
      g++ \
      libmagic-dev \
      libpq-dev \
      make \
      patch

COPY Gemfile Gemfile.lock /opt/meeemories/
RUN bundle install

COPY . /opt/meeemories/
