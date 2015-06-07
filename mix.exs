defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.7.0",
      elixir: ">= 1.0.4",
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
      {:httpoison, "~> 0.7"},
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
    "Webdriver library for integration testing and browser automation."
  end
end
