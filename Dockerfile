# this dockerfile is for heroku
FROM ruby:2.5-alpine as Builder
ARG RAILS_ENV=production
ENV LANG C.UTF-8
ENV APP_ROOT /opt/app
WORKDIR $APP_ROOT
COPY Gemfile* ./
RUN set -x \
  && apk update \
  && apk upgrade \
  && apk add --update --no-cache bash            \
                                 gmp-dev         \
                                 imagemagick     \
                                 less            \
                                 nodejs          \
                                 openssh         \
                                 postgresql      \
                                 python2         \
                                 tzdata          \
                                 yaml            \
                                 yarn            \
  && apk add --update --no-cache --virtual build-dependencies \
                                           build-base         \
                                           alpine-sdk         \
                                           libxml2-dev        \
                                           libxslt-dev        \
                                           postgresql-dev     \
  && gem install bundler \
  && bundle install --path vendor/bundle --without development test -j8 \
  && apk del build-dependencies
COPY . ./
RUN adduser -D myuser
USER myuser