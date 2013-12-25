# Hound

Elixir library to write integration tests using webdriver.

<a href="http://akash.im/docs/hound" target="_blank">Documentation</a>

[![Build Status](https://travis-ci.org/HashNuke/hound.png?branch=master)](https://travis-ci.org/HashNuke/hound)

## Features

* Can run __multiple browser sessions__ simultaneously. [See example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

* Supports Selenium (Firefox, Chrome) and PhantomJs.

* Implements the WebDriver Wire Protocol.


**IE may work, but hasn't been tested.

#### Example

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

## Setup

* Add dependency to your mix project

        { :hound, github: "HashNuke/hound" }

* Start Hound in `test_helper.exs`

        # Start Hound for localhost webdriver server (Selenium assumed at port 4444)
        Hound.start

        # Start Hound for remote webdriver server at port 5555
        Hound.start [host: "http://example.com", port: 5555]


__You'll need a webdriver server__ running, like Selenium Server or Chrome Driver. If you aren't sure what it is, then [read this](https://github.com/HashNuke/hound/wiki/Starting-a-webdriver-server)

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

The docs are at <http://akash.im/docs/hound>.

### More examples? [Checkout Hound's own test cases](https://github.com/HashNuke/hound/tree/master/test/json_driver)

## Run multiple browser sessions simultaneously

Oh yeah ~! [Here is an example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

If you are running PhantomJs, take a look at the *Caveats* section below.

## Caveats

PhantomJs is extremely fast, but there are certain caveats. It uses Ghostdriver for it's webdriver server, which currently has unimplemented features or open issues.

* Cookie jar isn't seperate for sessions - <https://github.com/ariya/phantomjs/issues/11417>
  Which means all sessions share the same cookies. Make sure you run `delete_cookies()` at the end of each test.
* Sessions are not isolated - <https://github.com/detro/ghostdriver/issues/170>.
* Javascript alerts aren't yet supported - <https://github.com/detro/ghostdriver/issues/20>.


## License

Copyright &copy; 2013, Akash Manohar J, under the MIT License