defmodule WeatherApp.TableFormatter do
  @units ["", "", "C", "Mph", "", "%", "C"]
  @headers ["Keys", "Values"]

  import Enum, only: [map: 2, map_join: 3, max: 1, each: 2]

  def print_table_for_columns(keys, extracted_column) do
    with columns = [keys, append_units(extracted_column)],
         column_widths = widths_of(columns),
         format = format_for(column_widths) do
      puts_one_line_in_columns(@headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(columns, format)
    end
  end

  def widths_of(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  def format_for(column_widths) do
    map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def append_units(values) do
    zipped = List.zip([values, @units])
    map(zipped, fn {value, unit} -> "#{value} #{unit}" end)
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> map(&Tuple.to_list/1)
    |> each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(line, format) do
    :io.format(format, line)
  end
end
