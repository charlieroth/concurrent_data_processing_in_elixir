defmodule Airports.MixProject do
  use Mix.Project

  def project do
    [
      app: :airports,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Airports.Application, []}
    ]
  end

  defp deps do
    [
      {:flow, "~> 1.2"},
      {:nimble_csv, "~> 1.2"}
    ]
  end
end
