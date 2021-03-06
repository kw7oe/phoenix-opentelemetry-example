import Config

if config_env() == :prod do
  config :demo, Demo.Repo,
    # ssl: true,
    url: System.fetch_env!("DATABASE_URL"),
    pool_size: 10

  config :demo, DemoWeb.Endpoint,
    server: true,
    url: [host: System.get_env("HOST") || "localhost"],
    http: [
      port: 4000,
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

  config :opentelemetry, :processors,
    otel_batch_processor: %{
      # Using `otel` here since we are starting through docker-compose where
      # otel refer to the hostname of the OpenCollector,
      #
      # If you are running it locally, kindly change it to the correct
      # hostname such as `localhost`, `0.0.0.0` and etc.
      exporter: {:opentelemetry_exporter, %{endpoints: [{:http, 'otel', 55681, []}]}}
    }
end
