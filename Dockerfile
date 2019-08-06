FROM ruby:2.6-alpine as Builder
ENV LANG C.UTF-8
ENV APP_ROOT /opt/app
WORKDIR $APP_ROOT
COPY Gemfile* ./
RUN set -x \
  && apk update \
  && apk upgrade \
  && apk add --update --no-cache bash           \
                                 git            \
                                 gmp-dev        \
                                 openssh        \
                                 nodejs-current \
                                 nodejs-npm     \
                                 postgresql     \
                                 python2        \
                                 tzdata         \
                                 yaml           \
                                 yarn           \
  && apk add --update --no-cache --virtual build-dependencies \
                                           build-base         \
                                           curl-dev           \
                                           gcc                \
                                           libc-dev           \
                                           libxml2-dev        \
                                           libxslt-dev        \
                                           linux-headers      \
                                           make               \
                                           postgresql-dev     \
  && gem install bundler \
  && bundle install --path vendor/bundle -j4 \
  && apk del build-dependencies
COPY . ./

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Add a user to not run as a root-user
RUN adduser -D myuser
USER myuser

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
