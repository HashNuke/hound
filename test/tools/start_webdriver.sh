if [[ $WEBDRIVER == "phantomjs" ]]
then
    npm install -g phantomjs
    nohup `which phantomjs` --webdriver &
    echo "Running with PhantomJs..."
elif [[ $WEBDRIVER == "selenium" ]]
then
  cd ~/src
  wget https://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar
  nohup java -jar selenium-server-standalone-2.39.0.jar &
  echo "Running with Selenium..."
fi
