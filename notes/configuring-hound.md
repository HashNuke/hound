## Configuring Hound

To configure Hound, use the project's `config/config.exs` file or equivalent (v0.14.0 and above). Here are some examples:

```elixir
# Start with selenium driver (default)
config :hound, driver: "selenium"
```

```elixir
# Use Chrome with the default driver (selenium)
config :hound, browser: "chrome"
```

```elixir
# Start with default driver at port 1234 and use firefox
config :hound, port: 1234, browser: "firefox"
```

```elixir
# Start Hound for PhantomJs
config :hound, driver: "phantomjs"
```

```elixir
# Start Hound for ChromeDriver (default port 9515 assumed)
config :hound, driver: "chrome_driver"
```

```elixir
# Use Chrome in headless mode with ChromeDriver (default port 9515 assumed) 
config :hound, driver: "chrome_driver", browser: "chrome_headless"
```

```elixir
# Start Hound for remote PhantomJs server at port 5555
config :hound, driver: "phantomjs", host: "http://example.com", port: 5555
```

```elixir
# Define your application's host and port (defaults to "http://localhost:4001")
config :hound, app_host: "http://localhost", app_port: 4001
```

```elixir
# Define how long the application will wait between failed attempts (in miliseconds)
config :hound, retry_time: 500
```

```elixir
# Define http client settings
config :hound, http: [recv_timeout: :infinity, proxy: ["socks5", "127.0.0.1", "9050"]]
```
