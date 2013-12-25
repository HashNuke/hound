# Hound

Elixir WebDriver library

[![Build Status](https://travis-ci.org/HashNuke/hound.png?branch=master)](https://travis-ci.org/HashNuke/hound)

## Features

* Supports running __multiple browser sessions__ simultaneously !!!
* Implements the [WebDriver Wire Protocol](https://code.google.com/p/selenium/wiki/JsonWireProtocol) based on the W3C WebDriver spec.


#### Example

```elixir
defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "the truth", meta do
    #TODO need a better example
    navigate_to("http://google.com")
    assert(true)
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


### Helpers

TODO add links to the following

* Page
* Element
* Navigation
* Orientation
* Cookies
* Dialog
* Javascript execution


### Multiple browser sessions simultaneously

Oh yeah ~! Hound makes that possible. [Checkout our test case for that](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

It works perfectly fine with Selenium and Firefox.

However, if you are running PhantomJs, take a look at the *Caveats* section below.

## Caveats

PhantomJs is extremely fast, but there are certain caveats. It uses Ghostdriver for it's webdriver server, which currently has unimplemented features or open issues.

* Cookie jar isn't seperate for sessions - <https://github.com/ariya/phantomjs/issues/11417>
  Which means all sessions share the same cookies. Make sure you run `delete_cookies()` in each cookies in each test case.
* Sessions are not isolated - <https://github.com/detro/ghostdriver/issues/170>.
* Javascript alerts aren't yet supported - <https://github.com/detro/ghostdriver/issues/20>.


## License

Copyright &copy; 2013, Akash Manohar J, under the MIT License