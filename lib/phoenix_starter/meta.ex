defmodule PhoenixStarter.Meta do
  @moduledoc """
    Converts URLs.
  """

  @title """
    Phoenix Starter
  """

  @description """
    | List what you need. Someone can help you get it.
  """

  def html_title, do: @description
  def html_description, do: @description
  def rss_title, do: @description
end
