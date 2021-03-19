defmodule Hound.Mixfile do
  use Mix.Project

  @source_url "https://github.com/HashNuke/hound"
  @version "1.1.1"

  def project do
    [
      app: :hound,
      version: @version,
      elixir: "~> 1.4",
      source_url: @source_url,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Hound, []}
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.5"},
      {:jason, "~> 1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "Webdriver library for integration testing and browser automation",
      maintainers: ["Akash Manohar J", "Daniel Perez"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_url: @source_url,
      source_ref: "#{@version}",
      formatters: ["html"]
    ]
  end
end
