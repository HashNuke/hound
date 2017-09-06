#!/usr/bin/env bash

if [ "$WEBDRIVER" = "phantomjs" ]; then
  npm install -g phantomjs
  nohup phantomjs -w &
  echo "Running with PhantomJs..."
  sleep 3
elif [ "$WEBDRIVER" = "selenium" ]; then
  mkdir -p $HOME/src $HOME/bin
  wget http://selenium-release.storage.googleapis.com/3.5/selenium-server-standalone-3.5.3.jar
  curl -L https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz | tar xz -C $HOME/bin
  export PATH="$HOME/bin:$PATH"
  nohup java -jar selenium-server-standalone-3.5.3.jar &
  echo "Running with Selenium..."
  sleep 10
fi
