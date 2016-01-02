defmodule CloudVision.Feature do
  alias __MODULE__

  defstruct type: nil, max_results: nil

  def label(max_results \\ -1) do
    %Feature{type: "LABEL_DETECTION", max_results: max_results}
  end

  def face(max_results \\ -1) do
    %Feature{type: "FACE_DETECTION", max_results: max_results}
  end

  def landmark(max_results \\ -1) do
    %Feature{type: "LANDMARK_DETECTION", max_results: max_results}
  end

  def logo(max_results \\ -1) do
    %Feature{type: "LOGO_DETECTION", max_results: max_results}
  end

  def text(max_results \\ -1) do
    %Feature{type: "TEXT_DETECTION", max_results: max_results}
  end

  def safe_search(max_results \\ -1) do
    %Feature{type: "SAFE_SEARCH_DETECTION", max_results: max_results}
  end

  def unspecified(max_results \\ -1) do
    %Feature{type: "TYPE_UNSPECIFIED", max_results: max_results}
  end
end


defmodule CloudVision.Image do
  alias __MODULE__

  defstruct content: nil

  def new(content) do
    %Image{content: content}
  end

  def from_file(path) do
    case File.read path do
      {:ok, body} -> {:ok, body |> Base.encode64 |> Image.new}
      {:error, reason} -> {:error, reason}
    end
  end

  def from_file!(path) do
    path
      |> File.read!
      |> Base.encode64
      |> Image.new
  end
end

defmodule CloudVision.Face do
  alias CloudVision.BoundingPoly
  alias CloudVision.Landmark

  defstruct bounding_poly: nil,
    fd_bounding_poly: nil,
    landmarks: nil,
    roll_angle: nil,
    tilt_angle: nil,
    detection_confidence: nil,
    landmarking_confidence: nil,
    joy_likelihood: nil,
    sorrow_likelihood: nil,
    anger_likelihood: nil,
    surprise_likelihood: nil,
    under_exposed_likelihood: nil,
    blurred_likelihood: nil,
    headwear_likelihood: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "bounding_poly" -> {:bounding_poly, BoundingPoly.from_map(val)}
          "fd_bounding_poly" -> {:fd_bounding_poly, BoundingPoly.from_map(val)}
          "landmarks" -> {:landmarks, Enum.map(val, &Landmark.from_map(&1))}
          "roll_angle" -> {:roll_angle, val}
          "pan_angle" -> {:pan_angle, val}
          "tilt_angle" -> {:tilt_angle, val}
          "detection_confidence" -> {:detection_confidence, val}
          "landmarking_confidence" -> {:landmarking_confidence, val}
          "joy_likelihood" -> {:joy_likelihood, val}
          "sorrow_likelihood" -> {:sorrow_likelihood, val}
          "anger_likelihood" -> {:anger_likelihood, val}
          "surprise_likelihood" -> {:surprise_likelihood, val}
          "under_exposed_likelihood" -> {:under_exposed_likelihood, val}
          "blurred_likelihood" -> {:blurred_likelihood, val}
          "headwear_likelihood" -> {:headwear_likelihood, val}
        end
      end
    )
  end
end

defmodule CloudVision.BoundingPoly do
  alias CloudVision.Vertex

  defstruct vertices: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "vertices" -> {:vertices, Enum.map(val, &Vertex.from_map(&1))}
        end
      end
    )
  end
end

defmodule CloudVision.Vertex do
  defstruct x: nil, y: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "x" -> {:x, val}
          "y" -> {:y, val}
        end
      end
    )
  end
end

defmodule CloudVision.Landmark do
  alias CloudVision.Position

  defstruct type: nil, position: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "type" -> {:type, val}
          "position" -> {:position, Position.from_map(val)}
        end
      end
    )
  end
end

defmodule CloudVision.Position do
  defstruct x: nil, y: nil, z: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "x" -> {:x, val}
          "y" -> {:y, val}
          "z" -> {:z, val}
        end
      end
    )
  end
end

defmodule CloudVision.EntityAnnotation do
  alias CloudVision.BoundingPoly
  alias CloudVision.LocationInfo

  defstruct mid: nil,
    locale: nil,
    description: nil,
    score: nil,
    confidence: nil,
    topicality: nil,
    bounding_poly: nil,
    locations: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "mid" -> {:mid, val}
          "local" -> {:local, val}
          "description" -> {:description, val}
          "score" -> {:score, val}
          "confidence" -> {:confidence, val}
          "topicality" -> {:topicality, val}
          "bounding_poly" -> {:bounding_poly, BoundingPoly.from_map(val)}
          "locations" -> {:locations, Enum.map(val, &LocationInfo.from_map(&1))}
        end
      end
    )
  end
end

defmodule CloudVision.LocationInfo do
  alias CloudVision.LatLng

  defstruct lat_lng: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "lat_lng" -> {:lat_lng, LatLng.from_map(val)}
        end
      end
    )
  end
end

defmodule CloudVision.LatLng do
  defstruct latitude: nil, longitude: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "latitude" -> {:latitude, val}
          "longitude" -> {:longitude, val}
        end
      end
    )
  end
end

defmodule CloudVision.SafeSearchAnnotation do
  defstruct porn_likelihood: nil, spoof_likelihood: nil, medical_likelihood: nil, violence_likelihood: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "porn_likelihood" -> {:porn_likelihood, val}
          "spoof_likelihood" -> {:spoof_likelihood, val}
          "medical_likelihood" -> {:medical_likelihood, val}
          "violence_likelihood" -> {:violence_likelihood, val}
        end
      end
    )
  end
end

defmodule CloudVision.Status do
  defstruct code: nil, message: nil, details: nil

  def from_map(map) do
    struct(__struct__,
      for {key, val} <- map, into: %{} do
        case key do
          "code" -> {:code, val}
          "message" -> {:message, val}
          "details" -> {:details, val}
        end
      end
    )
  end
end
