defmodule Human do
  defcallback greet(name :: String.t) :: String.t
end

defmodule Akash do
  use Human

  
end

IO.inspect Human.greet