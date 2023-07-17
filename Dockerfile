# Dockerfile

FROM ruby:latest

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]