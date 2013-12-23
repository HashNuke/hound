# Hound

Elixir WebDriver library

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


### Multiple browser sessions simultaneously

I know, you are curious, check it out

### Helpers

TODO add links to the following

* Page
* Element
* Navigation
* Orientation
* Cookies
* Dialog
* Javascript execution

## Reference

https://code.google.com/p/selenium/wiki/JsonWireProtocol


## License

Copyright &copy; 2013, Akash Manohar J, under the MIT License