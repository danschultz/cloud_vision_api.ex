defmodule CloudVision.Request do
  alias __MODULE__

  defstruct image: nil, features: nil

  def new(image, features) do
    %Request{image: image, features: features}
  end
end
