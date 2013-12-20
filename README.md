# Hound (work in progress)

Elixir WebDriver library

## Features

* Supports running __multiple browser sessions__ !!!
* Implements the [WebDriver Wire Protocol](https://code.google.com/p/selenium/wiki/JsonWireProtocol) based on the W3C WebDriver spec.


## Setup

* Add dependency to your mix project

        { :hound, github: "HashNuke/hound" }

* Start Hound in `test_helper.exs`

        # Start Hound for localhost webdriver server (Selenium assumed at port 4444)
        Hound.start

        # Start Hound for remote webdriver server at port 5555
        Hound.start [host: "http://example.com", port: 5555]


__You'll need a webdriver server__, like Selenium server, running before you start your tests. If you aren't sure what it is, then r[read this](https://github.com/HashNuke/hound/wiki/Starting-a-webdriver-server)

## Usage

Add the following lines to your test files

```elixir
# Import helpers
use Hound.Helpers

# Start hound session and destroy when tests are run
hound_session
```

#### Example

```elixir
defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "the truth", meta do
    navigate_to("http://google.com")
    assert(true)
  end

end
```

If you prefer to manually start and end sessions, use `Hound.start_session` and `Hound.end_session` in the setup and teardown blocks of your tests.


### Multiple browser support



### Helpers



### Reference

https://code.google.com/p/selenium/wiki/JsonWireProtocol
