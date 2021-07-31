defmodule ParserTest do
  use ExUnit.Case

  alias WeatherApp.Weather, as: WParser

  @xml_test_data """
  <bookstore>
    <book>
      <title lang="en">Learning XML</title>
      <price>39.95</price>
    </book>
  </bookstore>
  """

  test "parse and return given in text values" do
    document = WParser.parse_body(@xml_test_data)
    assert WParser.get_text_from_element(document, "title") == "Learning XML"
    assert WParser.get_text_from_element(document, "price") == "39.95"
  end
end
