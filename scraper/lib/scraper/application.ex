defmodule Scraper.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: ProducerConsumerRegistry},
      PageProducer,
      %{
        id: "online_page_producer_consumer_1",
        start: {
          OnlinePageProducerConsumer,
          :start_link,
          ["online_page_producer_consumer_1"]
        }
      },
      %{
        id: "online_page_producer_consumer_2",
        start: {
          OnlinePageProducerConsumer,
          :start_link,
          ["online_page_producer_consumer_2"]
        }
      },
      PageConsumerSupervisor
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
