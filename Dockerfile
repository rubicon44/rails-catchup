FROM ruby:2.6.3-alpine

ENV CHROME_PACKAGES="chromium-chromedriver zlib-dev chromium xvfb wait4ports xorg-server dbus ttf-freefont mesa-dri-swrast udev"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${CHROME_PACKAGES} \
    build-base \
    imagemagick \
    mariadb-dev \
    tzdata \
    nodejs \
    yarn

RUN mkdir /rails-catchup
ENV APP_ROOT /rails-catchup
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
COPY package.json $APP_ROOT/package.json
COPY yarn.lock $APP_ROOT/yarn.lock
RUN bundle install
COPY . $APP_ROOT

RUN mkdir -p tmp/sockets tmp/pids
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]
EXPOSE  3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]