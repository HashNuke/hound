## Simple browser automation using Hound

```elixir
Application.start :hound

defmodule Example do
  use Hound.Helpers

  def run do
    Hound.start_session

    navigate_to "http://akash.im"
    IO.inspect page_title()

    # Automatically invoked if the session owner process crashes
    Hound.end_session
  end
end

Example.run
```
