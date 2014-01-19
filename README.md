# Hound

For browser automation and writing integration tests in Elixir.

<a href="http://github.com/HashNuke/Hound" target="_parent">Source</a> | <a href="http://akash.im/docs/hound" target="_parent">Documentation</a>

[![Build Status](https://travis-ci.org/HashNuke/hound.png?branch=master)](https://travis-ci.org/HashNuke/hound)

## Features

* Can run __multiple browser sessions__ simultaneously. [See example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

* Supports Selenium (Firefox, Chrome), ChromeDriver and PhantomJs.

* Implements the WebDriver Wire Protocol.


**Internet Explorer may work under Selenium, but hasn't been tested.


#### Example

##### ExUnit example

```elixir
defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "the truth", meta do
    navigate_to("http://example.com/guestbook.html")

    find_element(:name, "message")
    |> fill_field("Happy Birthday ~!")
    |> submit_element()

    assert page_title() == "Thank you"
  end

end
```

##### Simple browser automation

```elixir
# This needs to be started before before using the helpers
{:ok, _hound_pid} = Hound.start()

defmodule Example do
  use Hound.Helpers

  def run do
    Hound.start_session

    navigate_to "http://akash.im"
    IO.inspect page_title()

    Hound.end_session
  end
end

Example.run
```

## Setup

Hound requires Erlang R16B02 or higher.

* Add dependency to your mix project

        { :hound, github: "HashNuke/hound", tag: "v0.5.1" }

* Start Hound in `test_helper.exs`. Here are some examples:

        # Start Hound for Selenium server (default port 4444 assumed)
        Hound.start

        # Or, you can also use
        Hound.start([driver: "selenium"])

        # Start Hound for Selenium at port 1234 and use firefox browser
        Hound.start [port: 1234, browser: "firefox"]

        # Start Hound for ChromeDriver (default port 9515 assumed)
        Hound.start [driver: "chrome_driver"]

        # Start Hound for PhantomJs (default port 8910 assumed)
        Hound.start [driver: "phantomjs"]

        # Start Hound for remote phantomjs server at port 5555
        Hound.start [driver: "phantomjs", host: "http://example.com", port: 5555]


__You'll need a webdriver server__ running, like Selenium Server or Chrome Driver. If you aren't sure what it is, then [read this](https://github.com/HashNuke/hound/wiki/Starting-a-webdriver-server).

## Usage

Add the following lines to your test files

```elixir
# Import helpers
use Hound.Helpers

# Start hound session and destroy when tests are run
hound_session
```

If you prefer to manually start and end sessions, use `Hound.start_session` and `Hound.end_session` in the setup and teardown blocks of your tests.


## Helpers

The documentation pages include examples under each function.

* [Navigation](http://akash.im/docs/hound/Hound.JsonDriver.Navigation.html)
* [Page](http://akash.im/docs/hound/Hound.JsonDriver.Page.html)
* [Element](http://akash.im/docs/hound/Hound.JsonDriver.Element.html)
* [Cookies](http://akash.im/docs/hound/Hound.JsonDriver.Cookie.html)
* [Javascript execution](http://akash.im/docs/hound/Hound.JsonDriver.ScriptExecution.html)
* [Javascript dialogs](http://akash.im/docs/hound/Hound.JsonDriver.Dialog.html)
* [Screenshot](http://akash.im/docs/hound/Hound.JsonDriver.Screenshot.html)
* [Session](http://akash.im/docs/hound/Hound.JsonDriver.Session.html)

The docs are at <http://akash.im/docs/hound>.

### More examples? [Checkout Hound's own test cases](https://github.com/HashNuke/hound/tree/master/test/json_driver)

## FAQ

#### Can I run multiple browser sessions simultaneously

Oh yeah ~! [Here is an example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

If you are running PhantomJs, take a look at the *Caveats* section below.

#### Can I run tests async?

Yes.

The number of tests you can run async at any point in time, depends on the number of sessions that your webdriver can maintain at a time. For Selenium Standalone, there seems to be a default limit of 15 sessions. You can set ExUnit's async option to limit the number of tests to run parallelly.

#### Will Hound gurantee an isolated session per test?

Yes. A seperate session is started for each session. 

## PhantomJs caveats

PhantomJs is extremely fast, but there are certain caveats. It uses Ghostdriver for it's webdriver server, which currently has unimplemented features or open issues.

* Cookie jar isn't seperate for sessions - <https://github.com/ariya/phantomjs/issues/11417>
  Which means all sessions share the same cookies. Make sure you run `delete_cookies()` at the end of each test.
* Isolated sessions were added to GhostDriver recently and are yet to land in a PhantomJs release.
* Javascript alerts aren't yet supported - <https://github.com/detro/ghostdriver/issues/20>.


## License

Copyright &copy; 2013, Akash Manohar J, under the MIT License
