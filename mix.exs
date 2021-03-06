defmodule SlackBot.Mixfile do
  use Mix.Project

  def project do
    [app: :slack_bot,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     aliases: [test: "test --no-start"],
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  # Type "mix help compile.app" for more information
  def application do
    [ mod: {SlackBot, []},
      applications: [:logger, :httpoison]]
  end

  use Mix.Config
  import_config "config/config.exs"


  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:socket, git: "https://github.com/meh/elixir-socket"},
      {:httpoison, "~> 0.8.1"},
      {:poison, "~> 2.0"},
      {:mock, "~> 0.1.1", only: :test}]
  end
end
