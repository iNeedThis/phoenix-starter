use Mix.Config

alias Phoenix.PubSub.{PG2}
alias PhoenixStarter.{Endpoint, PubSub, GuardianSerializer, Repo}
alias Ueberauth.Strategy.{Github, Facebook, Google, Slack, Twitter, Fitbit, Identity}

config :phoenix_starter, Endpoint,
  url:             [host: "localhost"],
  root:            Path.dirname(__DIR__),
  secret_key_base: "m6b9EGgoTxATviy/Ujx2stZC8UXkw2MMXACAXQR1btpZtV+FtQfl9kL7WoU5mvrD",
  render_errors:   [accepts: ~w(html json)],
  pubsub: [
    name:    PubSub,
    adapter: PG2
  ]

config :logger, :console,
  format:   "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  issuer:        "PhoenixStarter.#{Mix.env}",
  ttl:           {30, :days},
  verify_issuer: true,
  serializer:    GuardianSerializer,
  secret_key:    to_string(Mix.env),
  hooks:         GuardianDb,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
  }

config :ueberauth, Ueberauth,
  providers: [
    github:   { Github,   [uid_field: "login"] },
    slack:    { Slack,    [default_scope: "users:read,identify"] },
    google:   { Google,   [] },
    facebook: { Facebook, [profile_fields: "email, name"] },
    twitter:  { Twitter,  [] },
    fitbit:   { Fitbit,   [default_scope: "profile"] },
    identity: { Identity, [callback_methods: ["POST"]] },
  ]

config :ueberauth, Github.OAuth,
  client_id:       System.get_env("GITHUB_CLIENT_ID"),
  client_secret:   System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Slack.OAuth,
  client_id:       System.get_env("SLACK_CLIENT_ID"),
  client_secret:   System.get_env("SLACK_CLIENT_SECRET")

config :ueberauth, Google.OAuth,
  client_id:       System.get_env("GOOGLE_CLIENT_ID"),
  client_secret:   System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri:    "http://lvh.me:4000/auth/google/callback"

config :ueberauth, Facebook.OAuth,
  client_id:       System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret:   System.get_env("FACEBOOK_CLIENT_SECRET"),
  redirect_uri:    "http://lvh.me:4000/auth/facebook/callback"

config :ueberauth, Fitbit.OAuth,
  consumer_key:    System.get_env("FITBIT_CLIENT_ID"),
  consumer_secret: System.get_env("FITBIT_CLIENT_SECRET")

config :guardian_db, GuardianDb, repo: Repo

import_config "#{Mix.env}.exs"
