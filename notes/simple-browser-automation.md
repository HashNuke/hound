## Simple browser automation using Hound

```elixir
# use :application.start(:hound) if using Elixir 0.13.x
Application.start :hound

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
