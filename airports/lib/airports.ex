defmodule Airports do
  alias NimbleCSV.RFC4180, as: CSV

  def open_airports() do
    airports_csv()
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.map(fn row ->
      [row] = CSV.parse_string(row, skip_headers: false)

      %{
        id: Enum.at(row, 0),
        type: Enum.at(row, 2),
        name: Enum.at(row, 3),
        country: Enum.at(row, 8)
      }
    end)
    |> Flow.reject(&(&1.type == "closed"))
    |> Flow.partition(key: {:key, :country})
    |> Flow.group_by(& &1.country)
    |> Flow.on_trigger(fn airports_by_country ->
      country_counts =
        Enum.map(airports_by_country, fn {country, data} ->
          {country, Enum.count(data)}
        end)

      {country_counts, airports_by_country}
    end)
    |> Flow.take_sort(10, fn {_, a}, {_, b} -> a > b end)
    |> Enum.to_list()
    |> List.flatten()
  end

  def airports_csv() do
    Application.app_dir(:airports, "/priv/airports.csv")
  end
end
