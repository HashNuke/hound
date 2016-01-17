defmodule Hound.Mixfile do
  use Mix.Project

  @version "0.8.0"

  def project do
    [ app: :hound,
      version: @version,
      elixir: ">= 1.0.4",
      description: "Webdriver library for integration testing and browser automation",
      source_url: "https://github.com/HashNuke/hound",
      deps: deps,
      package: package,
      docs: [source_ref: "#{@version}", extras: ["README.md"], main: "extra-readme"]
    ]
  end


  def application do
    [
      applications: [:hackney, :httpoison, :logger],
      mod: { Hound, [] },
      description: 'Integration testing and browser automation library',
    ]
  end


  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison,    "~> 1.4"},
      {:earmark, "~> 0.1.17 or ~> 0.2", only: :docs},
      {:ex_doc,  "~> 0.10.0", only: :docs}
    ]
  end


  defp package do
    [
      maintainers: ["Akash Manohar J"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/HashNuke/hound",
        "Docs" => "http://hexdocs.pm/hound/"
      }
    ]
  end

end
