defmodule CloudVision.Images do
  alias CloudVision.Images.AnnotateResponse

  def annotate(client, requests) do
    body = %{"requests": requests}
    case client |> CloudVision.request(:post, "/images:annotate", body) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> parse_body}
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} when status_code >= 400 ->
        {:error, body |> Dict.fetch "error"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_body(%{"responses" => responses}) do
    responses |> Enum.map(&AnnotateResponse.from_map(&1))
  end
end

defmodule CloudVision.Images.AnnotateRequest do
  alias __MODULE__

  defstruct image: nil, features: nil

  def new(image, features) do
    %AnnotateRequest{image: image, features: features}
  end
end

defmodule CloudVision.Images.AnnotateResponse do
  alias CloudVision.Face
  alias CloudVision.EntityAnnotation
  alias CloudVision.Status

  defstruct faces: nil, landmarks: nil, labels: nil, logos: nil, text: nil, safe_search: nil, error: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "error" -> {:error, Status.from_map(val)}
          "face_annotations" -> {:faces, Enum.map(val, &Face.from_map(&1))}
          "label_annotations" -> {:labels, Enum.map(val, &EntityAnnotation.from_map(&1))}
          "landmark_annotations" -> {:landmarks, Enum.map(val, &EntityAnnotation.from_map(&1))}
          "logo_annotations" -> {:logos, Enum.map(val, &EntityAnnotation.from_map(&1))}
          "safe_search_annotation" -> {:safe_search, EntityAnnotation.from_map(val)}
          "text_annotations" -> {:text, Enum.map(val, &EntityAnnotation.from_map(&1))}
        end
      end
    )
  end
end
