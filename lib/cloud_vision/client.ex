defmodule CloudVision.Client do
  alias __MODULE__

  use HTTPoison.Base

  defstruct api_key: nil

  def new(api_key) do
    %Client{api_key: api_key}
  end

  def process_url(url) do
    api_uri <> url
  end

  def process_request_body(body) do
    CloudVision.Json.encode! body
  end

  def process_response_body(body) do
    CloudVision.Json.decode! body
  end

  def request(%Client{api_key: api_key}, method, endpoint, body) do
    request(method, endpoint <> "?key=" <> api_key, body, [], timeout: 15000, recv_timeout: 15000)
  end

  defp api_uri do
    Application.get_env(:cloud_vision, :api_uri)
  end
end
