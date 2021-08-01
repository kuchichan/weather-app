defmodule WeatherApp.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various function that end up generating a table
  of the last _n_ observation of weather at current 
  position
  """

  @doc """
  `argv` can be -h or --help, which returns :help
  Otherwise it is a location name and the number of
  hours of the last observation
  """
  @keys [
    "station_id",
    "weather",
    "temp_c",
    "wind_mph",
    "wind_dir",
    "relative_humidity",
    "dewpoint_c"
  ]

  import WeatherApp.TableFormatter, only: [print_table_for_columns: 2]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([location]) do
    location
  end

  def args_to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts("usage: weather: <location>")
  end

  def process(location) do
    location
    |> WeatherApp.Weather.get_weather()
    |> decode_response()
    |> get_values_for_keys()
    |> (&print_table_for_columns(@keys, &1)).()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from weather service: #{error["messgae"]}")
    System.halt(2)
  end

  def get_values_for_keys(doc) do
    Enum.map(@keys, &WeatherApp.Weather.get_text_from_element(doc, &1))
  end
end
