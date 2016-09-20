defmodule PhoenixStarter.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_starter,
      version: "0.0.1",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps
    ]
  end

  def application do
    [
      mod: {PhoenixStarter, []},
      applications: applications(Mix.env)
    ]
  end

  def applications(env) when env in [:test] do
    applications(:default) ++ [:ex_machina]
  end

  def applications(_) do
    [
      :comeonin,
      :cowboy,
      :logger,
      :oauth2,
      :phoenix,
      :phoenix_pubsub,
      :phoenix_ecto,
      :phoenix_html,
      :postgrex,
      :ueberauth_github,
      :ueberauth_identity,
      :ueberauth_slack,
      :ueberauth_google,
      :ueberauth_facebook,
      :ueberauth_twitter,
      :ueberauth_fitbit,
      :gettext
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      {:ex_admin, github: "smpallen99/ex_admin"},
      {:ex_machina, "~> 1.0", only: [:dev, :test]},
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0", override: true},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:guardian_db, "~> 0.4"},
      {:guardian, "~> 0.12"},
      {:ueberauth, git: "https://github.com/ueberauth/ueberauth.git", override: true},
      {:ueberauth_github, git: "https://github.com/ueberauth/ueberauth_github.git"},
      {:ueberauth_identity, "~> 0.2"},
      {:ueberauth_slack, "~> 0.3"},
      {:ueberauth_google, "~> 0.3"},
      {:ueberauth_facebook, "~> 0.4"},
      {:ueberauth_twitter, "~> 0.2"},
      {:ueberauth_fitbit, "~> 0.2"},
      {:oauth, github: "tim/erlang-oauth"},
      {:comeonin, "~> 2.5"},
      {:cowboy, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:edown, "~> 0.8"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
