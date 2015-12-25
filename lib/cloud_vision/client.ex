defmodule CloudVision.Client do
  alias __MODULE__
  alias CloudVision.Json
  alias CloudVision.Response

  defstruct api_key: nil, base_uri: "https://vision.googleapis.com/v1alpha1"

  def new(api_key) do
    %Client{api_key: api_key}
  end

  def annotate(client, requests) do
    uri = client |> build_uri("images:annotate")
    case HTTPoison.post uri, Json.encode!(%{"requests": requests}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> parse_body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp build_uri(client, path) do
    "#{client.base_uri}/#{path}?key=#{client.api_key}"
  end

  defp parse_body(body) do
    %{"responses" => responses} = body |> Json.decode!
    responses |> Enum.map(&Response.from_map(&1))
  end
end
