if [[ $WEBDRIVER == "phantomjs" ]]
then
    npm install -g phantomjs
    nohup phantomjs -w &
    echo "Running with PhantomJs..."
elif [[ $WEBDRIVER == "selenium" ]]
then
  cd ~/src
  wget http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar
  nohup java -jar selenium-server-standalone-2.43.1.jar &
  echo "Running with Selenium..."
fi
