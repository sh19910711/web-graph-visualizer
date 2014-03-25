#!/bin/bash

# tmp/testを削除
[ -d tmp/test ] && rm -rf tmp/test

# クライアント/サーバーで利用するモジュールなどの準備
mkdir -p tmp/test \
  && bundle install \
  && npm install

