defmodule Scraper do
  def online?(_ur) do
    work()

    Enum.random([false, true, false])
  end

  def work() do
    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end
end
