FROM ruby:2.6.5-alpine

RUN apk add --update --upgrade gcc git build-base xz-dev curl linux-headers

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

RUN bundle install

CMD ["ruby", "app.rb"]