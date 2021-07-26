defmodule WeatherApp.Weather do
  @weather_url Application.get_env(:weather_app, :weather_url)

  def weather_fetch_url(location) do
    "#{@weather_url}/xml/current_obs/#{location}.xml"
  end

  def get_weather(location) do
    location
    |> weather_fetch_url()
    |> HTTPoison.get()
  end

  def handle_response({:ok, %{status_code: status_code, body: body}}) do
    status_code |> handle_error()
  end

  def by_xpath(nil, _), do: []

  def by_xpath(node, path) do
    :xmerl_xpath.string(to_char_list(path), node)
  end

  def handle_error(200), do: :ok
  def handle_error(_), do: :error
end
