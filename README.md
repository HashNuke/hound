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
```

### Usage

* In your test files, add `use Hound.Helpers` to add helpers for ExUnit.

* Use the `hound_session` macro to start and end the hound sessions.

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

### Other stuff

If you don't prefer using `hound_session`, you can then manually use `Hound.start_session` and `Hound.end_session` in the setup and teardown blocks of your tests.

### Helpers

TODO


### Reference

https://code.google.com/p/selenium/wiki/JsonWireProtocol
