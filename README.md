# Google Cloud Vision API

[![Build Status](https://travis-ci.org/danschultz/cloud_vision_api.ex.svg)](https://travis-ci.org/danschultz/cloud_vision_api.ex)

Elixir client for Google's Cloud Vision API. Highly experimental!

## Installation

Add a git dependency to your `mix.exs` file:

```elixir
def deps do
  [{:cloud_vision, git: "git@github.com:danschultz/cloud_vision_api.ex.git"}]
end
```

## Usage

```elixir
alias CloudVision.Client
alias CloudVision.Image
alias CloudVision.Images
alias CloudVision.Images.AnnotateRequest
alias CloudVision.Feature

client = Client.new "my_api_key"
{:ok, image} = Image.from_file "path/to/image"
request = AnnotateRequest.new image, [Feature.face, Feature.landmark, Feature.label]
{:ok, response} = client |> Images.annotate [request]
```
