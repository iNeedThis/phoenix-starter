defmodule PhoenixStarter.Repo do
  use Ecto.Repo, otp_app: :phoenix_starter
  use Scrivener, page_size: 10
end
