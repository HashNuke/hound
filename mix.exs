defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.7.1",
      elixir: ">= 1.0.4",
      description: "Webdriver library for integration testing and browser automation",
      deps: deps,
      package: package
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
      {:httpoison, "~> 0.7"},
      {:poison,    "~> 1.4"},
      {:earmark, "~> 0.1", only: :docs},
      {:ex_doc,  "~> 0.7", only: :docs}
    ]
  end


  defp package do
    [
      contributors: ["Akash Manohar J"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/HashNuke/hound",
               "Docs" => "http://hexdocs.pm/hound/" }
    ]
  end

end
