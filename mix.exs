defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.7.0",
      elixir: ">= 1.0.2",
      description: description,
      deps: deps(Mix.env),
      package: package,
      docs: [readme: true, main: "README.md"]
    ]
  end


  def application do
    [
      applications: [:hackney, :httpoison],
      mod: { Hound, [] },
      description: 'Integration testing and browser automation library',
    ]
  end


  defp deps do
    [
      {:httpoison, "~> 0.5.0"},
      {:poison,    "~> 1.4.0"}
    ]
  end


  defp deps(:docs) do
    deps ++ [
      { :ex_doc,  github: "elixir-lang/ex_doc" },
      { :earmark, github: "pragdave/earmark" }
    ]
  end


  defp deps(_) do
    deps
  end


  defp package do
    [
      contributors: ["Akash Manohar J"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/HashNuke/hound" }
    ]
  end


  defp description do
    """
    Elixir library for browser automation and writing integration tests in Elixir.

    ## Features

    * Can run __multiple browser sessions__ simultaneously. [See example](https://github.com/HashNuke/hound/blob/master/test/multiple_browser_session_test.exs).

    * Supports Selenium (Firefox, Chrome), ChromeDriver and PhantomJs.

    * Supports Javascript-heavy apps. Retries a few times before reporting error.

    * Implements the WebDriver Wire Protocol.


    **Internet Explorer may work under Selenium, but hasn't been tested.
    """
  end
end
