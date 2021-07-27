defmodule WeatherApp.Weather do
  @weather_url Application.get_env(:weather_app, :weather_url)
  require Record
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  def weather_fetch_url(location) do
    "#{@weather_url}/xml/current_obs/#{location}.xml"
  end

  def get_weather(location) do
    location
    |> weather_fetch_url()
    |> HTTPoison.get()
  end

  def handle_response({:ok, %{status_code: status_code, body: body}}) do
    {
      status_code |> handle_error(),
      body |> parse_body()
    }
  end

  def parse_body(body) do
    body
    |> :binary.bin_to_list()
    |> :xmerl_scan.string()
    |> get_doc()
  end

  def get_doc({doc, _}), do: doc

  def by_xpath(nil, _), do: []

  def by_xpath(node, path) do
    :xmerl_xpath.string(to_charlist(path), node)
  end

  def get_text([xmlText(value: value)]), do: List.to_string(value)
  def get_text(_), do: nil

  def text([node]) do
    node
    |> by_xpath("./text()")
    |> get_text()
  end

  def text([]), do: nil

  def handle_error(200), do: :ok
  def handle_error(_), do: :error
end
