defmodule CliTest do
  use ExUnit.Case
  doctest WeatherApp

  import WeatherApp.CLI, only: [parse_args: 1]

  test ":help returned by option parser when -h, --help or anything else" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
    assert parse_args(["--help", "anything", "else"]) == :help
  end
end
