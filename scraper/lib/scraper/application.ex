defmodule Scraper.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PageProducer,
      %{
        id: :consumer_a,
        start: {PageConsumer, :start_link, [nil]}
      },
      %{
        id: :consumer_b,
        start: {PageConsumer, :start_link, [nil]}
      }
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
