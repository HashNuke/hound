#!/usr/bin/env bash

if [ "$WEBDRIVER" = "phantomjs" ]; then
  npm install -g phantomjs
  nohup phantomjs -w &
  echo "Running with PhantomJs..."
  sleep 3
elif [ "$WEBDRIVER" = "selenium" ]; then
  mkdir -p $HOME/src
  wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
  nohup java -jar selenium-server-standalone-3.141.59.jar &
  echo "Running with Selenium..."
  sleep 10
fi
