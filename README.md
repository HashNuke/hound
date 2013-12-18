# Hound (work in progress)

Elixir WebDriver library. Implements the W3C WebDriver spec. Supports Selenium.

Ships with free helpers for ExUnit.

### Setup

* Add `hound` as a dependency to your mix project

```elixir
{ :hound, github: "HashNuke/hound" }
```

* In your `mix` project, start the Hound application. See below for examples.

```elixir
# Start Hound for localhost webdriver server (Selenium assumed at port 4444)
Hound.start

# Start Hound for remote webdriver server at port 5555
Hound.start [host: "http://example.com", port: 5555]

# Start hound with a different driver.
# Right now Json driver is the default and only driver available.
# If you write a driver for a different webdriver server, then you can use it like this.
Hound.start [driver: Hound.YourFavouriteDriver]
```

### Usage

* In your test files, add `use Hound.ExUnitHelpers` to add helpers for ExUnit.

* Add `hound_session` to create a hound session for your tests.

```elixir
defmodule HoundTest do
  use ExUnit.Case
  use Hound.ExUnitHelpers

  hound_session

  test "the truth", meta do
    navigate_to("http://google.com")
    assert(true)
  end
end
```

### TODO

* Cookie
* Window size, position, maximize, close window, focus frame
* Mouse
* Geo location
* Local storage
* Session storage
* Session log
* Application cache status

### Reference

https://code.google.com/p/selenium/wiki/JsonWireProtocol
