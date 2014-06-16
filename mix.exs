defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.5.4",
      elixir: ">= 0.13.0",
      deps: deps(Mix.env),
      source_url: "http://github.com/HashNuke/hound",
      docs: [readme: true, main: "README"]
    ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:jsex, :ibrowse] ]
  end


  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat.git" }
  defp deps do
    [
      { :ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.0.2" },
      { :jsex,    github: "talentdeficit/jsex" }
    ]
  end


  defp deps(:docs) do
    deps ++ [
      { :ex_doc,  github: "elixir-lang/ex_doc" }
    ]
  end


  defp deps(_) do
    deps
  end
end
