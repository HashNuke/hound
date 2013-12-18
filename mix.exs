defmodule Hound.Mixfile do
  use Mix.Project

  def project do
    [ app: :hound,
      version: "0.0.1",
      elixir: ">= 0.12.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:ibrowse],
      mod: { Hound, [] }
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat.git" }
  defp deps do
    [
      { :ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.0.2" },
      { :jsex,    github: "talentdeficit/jsex" },
      { :ex_doc,  github: "elixir-lang/ex_doc" }
    ]
  end
end
