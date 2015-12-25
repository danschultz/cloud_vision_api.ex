defmodule CloudVision do
  alias __MODULE__

  use HTTPoison.Base

  defstruct api_key: nil

  @base_uri "https://vision.googleapis.com/v1alpha1"

  def new(api_key) do
    %CloudVision{api_key: api_key}
  end

  def process_url(url) do
    @base_uri <> url
  end

  def process_request_body(body) do
    CloudVision.Json.encode! body
  end

  def process_response_body(body) do
    CloudVision.Json.decode! body
  end

  def request(%CloudVision{api_key: api_key}, method, endpoint, body) do
    request(method, endpoint <> "?key=" <> api_key, body)
  end
end
