# Google Cloud Vision API

Elixir client for Google's Cloud Vision API. Highly experimental!

## Installation

Add a git dependency to your `mix.exs` file:

  def deps do
    [{:cloud_vision, git: "git@github.com:danschultz/cloud_vision_api.elixir.git"}]
  end

## Usage

```
alias CloudVision.Client
alias CloudVision.Image
alias CloudVision.Request
alias CloudVision.Feature

client = Client.new "my_api_key"
image = Image.from_file! "path/to/image"
request = Request.new image, [Feature.face, Feature.landmark, Feature.label]
{:ok, response} = client |> Client.annotate(request)
```
