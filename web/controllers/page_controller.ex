defmodule PhoenixStarter.PageController do
  use PhoenixStarter.Web, :controller

  def index(conn, _params, current_user, _claims) do
    render(conn, "index.html", current_user: current_user)
  end

  def about(conn, _params, current_user, _claims) do
    render(conn, "about.html", current_user: current_user)
  end

  def channels(conn, _params, current_user, _claims) do
    render(conn, "channels.html", current_user: current_user)
  end
end
