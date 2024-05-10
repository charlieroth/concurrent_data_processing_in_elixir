defmodule OnlinePageProducerConsumer do
  use Flow

  def start_link(_args) do
    producers = [Process.whereis(PageProducer)]
    IO.inspect(producers, label: "producers")

    consumers = [
      {Process.whereis(PageConsumerSupervisor), max_demand: 2}
    ]

    IO.inspect(consumers, label: "consumers")

    # handles start_link/1
    Flow.from_stages(
      producers,
      max_demand: 1,
      # flow will start two processes to manage incoming workload
      stages: 2
    )
    |> Flow.filter(&Scraper.online?/1)
    |> Flow.into_stages(consumers)
  end
end
