defmodule Hound.ResponseParsers.Selenium do
  @moduledoc false

  use Hound.ResponseParser

  def handle_error(%{"class" => "org.openqa.selenium.NoSuchElementException"}) do
    {:error, :no_such_element}
  end
end
