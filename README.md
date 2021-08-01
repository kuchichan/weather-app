# WeatherApp

**Yet another simple CLI tool that fetches weather parameters (wind, temperature and more) from [National Weather Service](https://w1.weather.gov)**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `weather_app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:weather_app, "~> 0.1.0"}
  ]
end
```

## Usage

```console
git clone https://github.com/kuchichan/weather-app
mix escript build
./weather_app KDTO

```

Which gives the following result:
```console

Keys              | Values 
------------------+--------
station_id        | KDTO
weather           | Fair 
temp_c            | 25.6 C 
wind_mph          | 0.0 Mph
wind_dir          | North
relative_humidity | 85 % 
dewpoint_c        | 22.8 
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/weather_app](https://hexdocs.pm/weather_app).

