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
