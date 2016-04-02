defmodule CjSlackBot.Mixfile do
  use Mix.Project

  def project do
    [app: :cj_slack_bot,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: CjSlackBot],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

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
