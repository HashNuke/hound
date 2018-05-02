# Hound

For browser automation and writing integration tests in Elixir.

<a href="http://github.com/HashNuke/Hound" target="_parent">Source</a> | <a href="http://hexdocs.pm/hound" target="_parent">Documentation</a>

[![Build Status](https://travis-ci.org/HashNuke/hound.png?branch=master)](https://travis-ci.org/HashNuke/hound)

## Features

* Can run __multiple browser sessions__ simultaneously. [See example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

* Supports Selenium (Firefox, Chrome), ChromeDriver and PhantomJs.

* Supports Javascript-heavy apps. Retries a few times before reporting error.

* Implements the WebDriver Wire Protocol.

**Internet Explorer may work under Selenium, but hasn't been tested.**

#### Example

##### ExUnit example

```elixir
defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "the truth", meta do
    navigate_to("http://example.com/guestbook.html")

    element = find_element(:name, "message")
    fill_field(element, "Happy Birthday ~!")
    submit_element(element)

    assert page_title() == "Thank you"
  end

end
```

Here's another [simple browser-automation example](https://github.com/HashNuke/hound/blob/master/notes/simple-browser-automation.md).

## Setup

Hound requires Elixir 1.0.4 or higher.

* Add dependency to your mix project

```elixir

{:hound, "~> 1.0"}
```

* Start Hound in your `test/test_helper.exs` file **before** the `ExUnit.start()` line:

```elixir
Application.ensure_all_started(:hound)
ExUnit.start()
```

When you run `mix test`, Hound is automatically started. __You'll need a webdriver server__ running, like Selenium Server or Chrome Driver. If you aren't sure what it is, then [read this](https://github.com/HashNuke/hound/wiki/Starting-a-webdriver-server).

#### If you're using Phoenix
Ensure the server is started when your tests are run. In `config/test.exs` change the `server` option of your endpoint config to `true`:

```elixir
config :hello_world_web, HelloWorldWeb.Endpoint,
  http: [port: 4001],
  server: true
```

## Configure

To configure Hound, use your `config/config.exs` file or equivalent.

Example:

```config :hound, driver: "phantomjs"```

[More examples here](https://github.com/HashNuke/hound/blob/master/notes/configuring-hound.md).

## Usage

Add the following lines to your ExUnit test files.

```elixir
# Import helpers
use Hound.Helpers

# Start hound session and destroy when tests are run
hound_session()
```

If you prefer to manually start and end sessions, use `Hound.start_session` and `Hound.end_session` in the setup and teardown blocks of your tests.


## Helpers

The documentation pages include examples under each function.

* [Navigation](http://hexdocs.pm/hound/Hound.Helpers.Navigation.html)
* [Page](http://hexdocs.pm/hound/Hound.Helpers.Page.html)
* [Element](http://hexdocs.pm/hound/Hound.Helpers.Element.html)
* [Cookies](http://hexdocs.pm/hound/Hound.Helpers.Cookie.html)
* [Javascript execution](http://hexdocs.pm/hound/Hound.Helpers.ScriptExecution.html)
* [Javascript dialogs](http://hexdocs.pm/hound/Hound.Helpers.Dialog.html)
* [Screenshot](http://hexdocs.pm/hound/Hound.Helpers.Screenshot.html)
* [Session](http://hexdocs.pm/hound/Hound.Helpers.Session.html)
* [Window](http://hexdocs.pm/hound/Hound.Helpers.Window.html)

The docs are at <http://hexdocs.pm/hound>.

### More examples? [Checkout Hound's own test cases](https://github.com/HashNuke/hound/tree/master/test/helpers)

## FAQ

#### Can I run multiple browser sessions simultaneously

Oh yeah ~! [Here is an example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

If you are running PhantomJs, take a look at the *Caveats* section below.

#### Can I run tests async?

Yes.

The number of tests you can run async at any point in time, depends on the number of sessions that your webdriver can maintain at a time. For Selenium Standalone, there seems to be a default limit of 15 sessions. You can set ExUnit's async option to limit the number of tests to run parallelly.

#### Will Hound guarantee an isolated session per test?

Yes. A separate session is started for each test process.

## PhantomJs caveats

PhantomJs is extremely fast, but there are certain caveats. It uses Ghostdriver for its webdriver server, which currently has unimplemented features or open issues.

* Cookie jar isn't separate for sessions - <https://github.com/ariya/phantomjs/issues/11417>
  Which means all sessions share the same cookies. Make sure you run `delete_cookies()` at the end of each test.
* Isolated sessions were added to GhostDriver recently and are yet to land in a PhantomJs release.
* Javascript alerts aren't yet supported - <https://github.com/detro/ghostdriver/issues/20>.

## Running tests

You need a webdriver in order to run tests. We recommend `phantomjs` but any can be used by setting the WEBDRIVER environment variable as shown below:

    $ phantomjs --wd
    $ WEBDRIVER=phantomjs mix test

## Maintainers

* Akash Manohar ([HashNuke](https://github.com/HashNuke))
* Daniel Perez ([tuvistavie](https://github.com/tuvistavie))

## Customary proclamation...

Copyright &copy; 2013-2015, Akash Manohar J, under the MIT License (basically, do whatever you want)
