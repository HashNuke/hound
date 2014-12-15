defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.6.0",
      elixir: ">= 1.0.2",
      description: description,
      deps: deps(Mix.env),
      package: package,
      docs: [readme: true, main: "README"]
    ]
  end


  # Configuration for the OTP application
  def application do
    [
      applications: [:httpoison],
      mod: { Hound, [] },
      description: 'Browser automation library',
    ]
  end


  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat.git" }
  defp deps do
    [
      {:httpoison, "~> 0.5.0"},
      {:poison,    "~> 1.3.0"}
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
