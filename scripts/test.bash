#!/bin/bash

# テストを実行する
bundle exec rake test > tmp/test/result-ruby.txt
npm run-script test

# タグなどの修正
for RESULT_PATH in `ls tmp/test/result-*.txt`; do
  cat ${RESULT_PATH} | sed -e "s/\[TODO\]/# TODO/" > `echo ${RESULT_PATH}`.2
done

# テスト結果の検証
prove tmp/test/result-*.txt.2 --exec "cat"

