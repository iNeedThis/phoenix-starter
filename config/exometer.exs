use Mix.Config

app_name         = :phoenix_starter
polling_interval = 1_000
histogram_stats  = ~w(min max mean 95 90)a
memory_stats     = ~w(atom binary ets processes total)a

config :exometer,
  predefined:
    [
      {
        ~w(erlang memory)a,
        {:function, :erlang, :memory, [], :proplist, memory_stats},
        []
      },
      {
        ~w(erlang statistics)a,
        {:function, :erlang, :statistics, [:'$dp'], :value, [:run_queue]},
        []
      },
      {
        [app_name, :ecto, :query_exec_time],
        :histogram,
        [truncate: :false]
      },
      {
        [app_name, :ecto, :query_queue_time],
        :histogram,
        [truncate: :false]
      },

      {
        [app_name, :ecto, :query_count],
        :spiral,
        []
      },
      {
        [app_name, :webapp, :resp_time],
        :histogram,
        [truncate: false]
      },
      {
        [app_name, :webapp, :resp_count],
        :spiral,
        []
      },
    ],

  reporters:
    [
      exometer_report_statsd:
      [
        hostname: System.get_env("PROD_HOST"),
        port: 8125
      ],
    ],

  report: [
    subscribers:
      [
        {
          :exometer_report_statsd,
          [app_name, :webapp, :resp_time], histogram_stats, polling_interval, true
        },
        {
          :exometer_report_statsd,
          [app_name, :ecto, :query_exec_time], histogram_stats, polling_interval, true
        },
        {
          :exometer_report_statsd,
          [:erlang, :memory], memory_stats, polling_interval, true
        },
        {
          :exometer_report_statsd,
          [app_name, :webapp, :resp_count], :one, polling_interval, true
        },
        {
          :exometer_report_statsd,
          [app_name, :ecto, :query_count], :one, polling_interval, true
        },
        {
          :exometer_report_statsd,
          [:erlang, :statistics], :run_queue, polling_interval, true
        },
      ]
  ]
