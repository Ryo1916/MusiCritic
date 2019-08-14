FROM ruby:2.5-alpine as Builder
ENV LANG C.UTF-8
ENV APP_ROOT /opt/app
WORKDIR $APP_ROOT
COPY Gemfile* ./
RUN set -x \
  && apk update \
  && apk upgrade \
  && apk add --update --no-cache alpine-sdk      \
                                 bash            \
                                 gmp-dev         \
                                 imagemagick     \
                                 less            \
                                 libxml2-dev     \
                                 libxslt-dev     \
                                 nodejs          \
                                 openssh         \
                                 postgresql      \
                                 postgresql-dev  \
                                 python2         \
                                 tzdata          \
                                 yaml            \
                                 yarn            \
  && gem install bundler \
  && bundle install --path vendor/bundle -j8
COPY . ./
RUN adduser -D myuser
USER myuser
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
