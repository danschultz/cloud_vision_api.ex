defmodule CloudVision.Json do
  def encode!(value), do: camelize_keys(value) |> Poison.encode!

  defp camelize_keys(value) when is_list(value) do
    for val <- value, do: camelize_keys(val)
  end

  defp camelize_keys(value) when is_map(value) do
    case value do
      %{:__struct__ => _} ->
        is_struct_key? = fn key -> key == :__struct__ end
        camelize_keys for key <- value |> Map.keys,
          !is_struct_key?.(key),
          into: %{},
          do: {key, Map.fetch!(value, key)}
      _ ->
        for {key, val} <- value,
          into: %{},
          do: {Inflex.camelize(key, :lower), val}
    end
  end

  defp camelize_keys(value), do: value

  def decode!(json) do
    json
      |> Poison.Parser.parse!
      |> underscore_keys
  end

  defp underscore_keys(value) when is_list(value) do
    for val <- value, do: underscore_keys(val)
  end

  defp underscore_keys(value) when is_map(value) do
    for {key, value} <- value, into: %{}, do: {Inflex.underscore(key), underscore_keys(value)}
  end

  defp underscore_keys(value), do: value
end
