defmodule Scraper do
  def online?(url) do
    work()

    is_online = Enum.random([true, true, true, true, false])

    if not is_online do
      IO.puts("#{url} is offline")
      is_online
    else
      is_online
    end
  end

  def work() do
    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end
end
