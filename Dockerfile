FROM ruby:2.3.3

RUN apt-get update && apt-get install -y -qq --no-install-recommends build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g phantomjs

RUN mkdir /miniweather
WORKDIR /miniweather

ADD Gemfile /miniweather/Gemfile
ADD Gemfile.lock /miniweather/Gemfile.lock

RUN bundle install

ADD . /miniweather

EXPOSE 3000
