defmodule PlugExometer do
  @behaviour Plug

  import Plug.Conn, only: [register_before_send: 2]

  alias :exometer, as: Exometer

  def init(opts), do: opts

  def call(conn, _config) do
    before_time = :os.timestamp

    register_before_send conn, fn conn ->
      after_time = :os.timestamp
      diff       = :timer.now_diff after_time, before_time

      :ok = Exometer.update [:phoenix_starter, :webapp, :resp_time], diff / 1_000
      :ok = Exometer.update [:phoenix_starter, :webapp, :resp_count], 1
      conn
    end
  end
end
