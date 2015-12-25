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
