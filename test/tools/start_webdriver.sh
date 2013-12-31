if [[ $WEBDRIVER == "chrome_driver" ]]
then
  "export DISPLAY=:99.0"
  "/sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16"
    cd ~/src
    sudo apt-get install chromium-browser
    wget http://chromedriver.storage.googleapis.com/2.8/chromedriver_linux64.zip
    unzip chromedriver_linux64.zip
    nohup /./$HOME/src/chromedriver &
    echo "Running with ChromeDriver..."
elif [[ $WEBDRIVER == "phantomjs" ]]
then
    nohup phantomjs -w &
    echo "Running with PhantomJs..."
elif [[ $WEBDRIVER == "selenium" ]]
then
  "export DISPLAY=:99.0"
  "/sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16"
  cd ~/src
  wget https://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar
  nohup java -jar selenium-server-standalone-2.39.0.jar &
  echo "Running with Selenium..."
fi
