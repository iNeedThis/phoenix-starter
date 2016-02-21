use Mix.Config

alias PhoenixStarter.{Endpoint, Repo}

config :phoenix_starter, Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: System.get_env("PROD_HOST"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :phoenix_starter, Repo,
  adapter:   Ecto.Adapters.Postgres,
  url:       System.get_env("DATABASE_URL"),
  pool_size: 20

config :logger, :console, level: :info
