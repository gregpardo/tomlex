defmodule Tomlex.Parser do
  import Tomlex.StringHelpers
  alias Tomlex.Line

  def parse(lines) do
    parse(lines, %{})
  end

  defp parse([], result), do: result

  defp parse([%Line.Float{key: key, value: value} | rest], result) do
    updated_result = Map.put result, String.to_atom(key), String.to_float(value)
    parse(rest, updated_result)
  end

  defp parse([%Line.Integer{key: key, value: value} | rest], result) do
    updated_result = Map.put result, String.to_atom(key), String.to_integer(value)
    parse(rest, updated_result)
  end

  defp parse([%Line.Boolean{key: key, value: value} | rest], result) do
    updated_result = Map.put result, String.to_atom(key), booleanize_string(value)
    parse(rest, updated_result)
  end

  defp parse([%Line.Assignment{key: key, value: value} | rest], result) do
    updated_result = Map.put result, String.to_atom(key), unquote_string(value)
    parse(rest, updated_result)
  end

  defp parse([%Line.Text{line: line} | rest], result) do
    parse(rest, result)
  end
end
