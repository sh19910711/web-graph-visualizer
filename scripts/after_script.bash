# ドキュメント作成
bundle exec rake doc
npm run-script doc

if [ "${TRAVIS_PULL_REQUEST}" == false ] && [ "${TRAVIS_BRANCH}" == "develop" ]; then
  git clone --quiet --single-branch -b gh-pages git://github.com/sh19910711/web-graph-visualizer.git tmp/gh-pages \
    && cp -r tmp/doc tmp/gh-pages/ \
    && cd tmp/gh-pages/ \
    && git config --global user.email "sh19910711+ynkkowrv0b14@gmail.com" \
    && git config --global user.name "Mr. Bot" \
    && git add doc \
    && git commit -m 'Update Document' \
    && git push --quiet https://${GITHUB_TOKEN}@github.com/sh19910711/web-graph-visualizer.git gh-pages
fi
