#! /usr/bin/env
MIX_ENV=docs mix docs
cd ../docs
git checkout gh-pages
rm -rf ../docs/hound
cp -R docs ../docs/hound
rm -rf docs
