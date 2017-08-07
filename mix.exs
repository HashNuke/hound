defmodule Hound.Mixfile do
  use Mix.Project

  @version "1.0.4"

  def project do
    [ app: :hound,
      version: @version,
      elixir: ">= 1.0.4",
      description: "Webdriver library for integration testing and browser automation",
      source_url: "https://github.com/HashNuke/hound",
      deps: deps(),
      package: package(),
      docs: [source_ref: "#{@version}", extras: ["README.md"], main: "readme"]
    ]
  end


  def application do
    [
      applications: [:hackney, :poison, :logger],
      mod: { Hound, [] },
      description: 'Integration testing and browser automation library',
    ]
  end


  defp deps do
    [
      {:hackney, "~> 1.5"},
      {:poison,  ">= 1.4.0"},
      {:earmark, "~> 1.2", only: :docs},
      {:ex_doc,  "~> 0.16", only: :docs}
    ]
  end


  defp package do
    [
      maintainers: ["Akash Manohar J", "Daniel Perez"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/HashNuke/hound",
        "Docs" => "http://hexdocs.pm/hound/"
      }
    ]
  end

end
