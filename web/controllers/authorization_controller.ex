defmodule PhoenixStarter.AuthorizationController do
  use PhoenixStarter.Web, :controller

  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html",
      current_user: current_user,
      authorizations: authorizations(current_user)
  end

  defp authorizations(user) do
    Ecto.assoc(user, :authorizations) |> Repo.all
  end

  # The unauthenticated function is called because this controller has been
  # specified as the handler.
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: auth_path(conn, :login, :identity))
  end
end
