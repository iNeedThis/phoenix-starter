defmodule PhoenixStarter.UserController do
  use PhoenixStarter.Web, :controller

  alias PhoenixStarter.{Repo, User, Authorization}

  def new(conn, params, current_user, _claims) do
    render conn, "new.html", current_user: current_user
  end
end
