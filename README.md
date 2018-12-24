# ExAws.Transcribe

[AWS Transcribe](https://docs.aws.amazon.com/transcribe/latest/dg/API_Operations.html) service module for [ex_aws](https://github.com/ex-aws/ex_aws).


## Usage

```elixir
alias ExAws.Transcribe

# Submit a transcription job
Transcribe.start_transcription_job("MyJob", "s3://bucket/file.mp3", "mp3", "en-US") |> ExAws.request!

# List jobs
Transcribe.list_transaction_jobs() |> ExAws.request!

# Get a job and retrieve the transcript if complete
job = Transcribe.get_transaction_job("MyJob") |> ExAws.request!
transcript_url = get_in(job, ["TranscriptionJob", "Transcript", "TranscriptFileUri"])
{:ok, {_, _, body}} = :httpc.request(:get, {transcript_url, []}, [], [])
```


## Installation

The package can be installed by adding ex_aws_transcribe to your list of dependencies
in mix.exs along with :ex_aws and your preferred JSON codec / http client

```
def deps do
  [
    {:ex_aws, "~> 2.0"},
    {:ex_aws_transcribe, "~> 0.1.0"},
    {:poison, "~> 3.0"},
    {:hackney, "~> 1.9"},
  ]
end
```

