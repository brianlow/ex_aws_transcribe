# ExAws.Transcribe

[AWS Transcribe](https://docs.aws.amazon.com/transcribe/latest/dg/API_Operations.html) service module for [ex_aws](https://github.com/ex-aws/ex_aws).


## Installation

The package can be installed by adding `ex_aws_transcribe` to your list of dependencies
in `mix.exs` along with your preferred JSON codec and http client:

```elixir
def deps do
  [
    {:ex_aws, "~> 2.1.1"},
    {:ex_aws_transcribe, "~> 0.2.2"},
    {:poison, "~> 3.0"},
    {:hackney, "~> 1.9"},
  ]
end
```


## Basic Usage

```elixir

# Start transcription
ExAws.Transcribe.start_transcription_job("MyJob", "s3://bucket/file.mp3", "mp3", "en-US") |> ExAws.request!

# Monitor progress
job = ExAws.Transcribe.get_transcription_job("MyJob") |> ExAws.request!

# Fetch the transcript if complete
:ssl.start()
:inets.start()
transcript_url = get_in(job, ["TranscriptionJob", "Transcript", "TranscriptFileUri"])
{:ok, {_, _, body}} = :httpc.request(:get, {to_charlist(transcript_url), []}, [], [])
```

## Listing jobs

```elixir

ExAws.Transcribe.list_transcription_jobs() |> ExAws.request!
```

## Specify settings

```elixir

settings = [settings: [show_speaker_labels: true, max_speaker_labels: 10]]

ExAws.Transcribe.start_transcription_job(name, url, format, language, settings) |> ExAws.request()
```


Full documentation can be found at <https://hexdocs.pm/ex_aws_transcribe>


## AWS Transcribe API Reference

<https://docs.aws.amazon.com/transcribe/latest/dg/API_Operations.html>

All options are handled as snake_case_atoms instead of CamelCase binaries as specified
in the Transcribe API. For example, `:media_format` would be `MediaFormat`.


