#! /usr/bin/env bash
MIX_ENV=docs mix docs
cd ../docs
git checkout gh-pages
cd -
rm -rf ../docs/hound
cp -R docs ../docs/hound
rm -rf docs
