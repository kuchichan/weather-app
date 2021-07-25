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
end
