use Mix.Config

alias PhoenixStarter.{Endpoint, Repo}

config :phoenix_starter, Endpoint,
  http:                [port: 4000],
  debug_errors:        true,
  code_reloader:       true,
  cache_static_lookup: false,
  check_origin:        false,
  watchers: [
    node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]
  ]

config :phoenix_starter, Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20

config :phoenix_starter, Repo,
  adapter:   Ecto.Adapters.Postgres,
  username:  System.get_env("DEV_DB_USERNAME"),
  password:  System.get_env("DEV_DB_PASSWORD"),
  database:  System.get_env("DEV_DB_NAME"),
  hostname:  "localhost",
  pool:      Ecto.Adapters.SQL.Sandbox,
  pool_size: 20
