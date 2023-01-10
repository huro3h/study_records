FROM ruby:3.1.3

ENV LANG C.UTF-8

RUN apt update -qq \
    && apt install -y build-essential \
    && apt install -y postgresql-client \
    && apt install -y vim \
    && apt install -y unzip  \
    && apt install -y chromium \
    && apt install -y chromium-driver \
    && apt install -y libidn11-dev \

# 最新のyarnを入れるために公開鍵を登録
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y

# 最新のnodejsを入れるためにリポジトリ登録
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash -
RUN apt install -y nodejs

ARG RUBYGEMS_VERSION=3.3.26

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install -j4 --retry=3

# コンテナー起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# イメージ実行時に起動させる主プロセスを設定
CMD ["/bin/bash"]
