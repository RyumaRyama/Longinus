# Debianがベースのrubyイメージを指定
FROM ruby:2.5.1

# 必要なものをインストール
RUN apt-get update -qq && apt-get -y install \
    build-essential \
    libpq-dev \
    nodejs

# rails用のディレクトリを作成
RUN mkdir /Longinus

# ローカルマシン(Mac)からコンテナの中にファイルをコピー
COPY Gemfile /Longinus
COPY Gemfile.lock /Longinus

# 作業ディレクトリを指定
WORKDIR /Longinus

RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java

# 上でコピーしたGemfileに従ってGemをインストール
RUN gem install bundler && bundle install
