defmodule AnnotateTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest CloudVision

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures")
    HTTPoison.start

    client = CloudVision.Client.new "123"
    image = CloudVision.Image.new ""
    request = CloudVision.Images.AnnotateRequest.new image, [CloudVision.Feature.face]

    {:ok, client: client, request: request}
  end

  test "face request", %{client: client, request: request} do
    use_cassette "face_request" do
      {:ok, [response | _]} = client |> CloudVision.Images.annotate [request]
      assert response.faces |> length == 2
    end
  end
end
