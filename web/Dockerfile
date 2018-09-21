# Debianがベースのrubyイメージを指定
FROM ruby:2.5.1

# 必要なものをインストール
RUN apt-get update -qq && apt-get -y install \
    build-essential \
    libpq-dev \
    nodejs \
    mysql-client

# rails用のディレクトリを作成
RUN mkdir /myapp

# ローカルマシン(Mac)からコンテナの中にファイルをコピー
COPY Gemfile /myapp
COPY Gemfile.lock /myapp

# 作業ディレクトリを指定
WORKDIR /myapp

# 上でコピーしたGemfileに従ってGemをインストール
RUN gem install bundler && bundle install
