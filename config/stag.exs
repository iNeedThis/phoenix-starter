use Mix.Config

alias PhoenixStarter.{Endpoint, Repo}

config :phoenix_starter, Endpoint,
  http: [port: {:system, "PORT"}],
  url:  [host: System.get_env("STAG_HOST"), port: 80],
  cache_static_manifest: "priv/static/manifest.json"

config :phoenix_starter, Repo,
  adapter:   Ecto.Adapters.Postgres,
  url:       System.get_env("DATABASE_URL"),
  pool_size: 20

config :logger, level: :info
