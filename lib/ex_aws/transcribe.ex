defmodule ExAws.Transcribe do
  @moduledoc """
    Operations for AWS Transcribe
  """

  import ExAws.Utils, only: [camelize_keys: 2]

  @version "2017-10-26"

  @doc """
    Starts an asynchronous job to transcribe speech to text.

    Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_StartTranscriptionJob.html>

    Example:
    ```
    Transcribe.start_transcription_job("MyJob", "s3://mybucket/myfile.mp3", "mp3", "en-US", settings: [show_speaker_labels: true])
    ```
  """
  @type media :: [
          media_file_uri: binary
        ]
  @type start_transcription_job_settings :: [
          channel_identification: boolean,
          max_speaker_labels: integer,
          show_speaker_labels: boolean,
          vocabulary_name: binary
        ]
  @type start_transcription_job_opts :: [
          language_code: binary,
          media: media,
          media_format: binary,
          transcription_job_name: binary,
          media_sample_rate_hertz: integer,
          output_bucket_name: binary,
          settings: start_transcription_job_settings
        ]
  @spec start_transcription_job(
          name :: binary,
          uri :: binary,
          format :: binary,
          language :: binary,
          start_transcription_job_opts
        ) :: ExAws.Operation.JSON.t()
  def start_transcription_job(name, uri, format, language, opts \\ []) do
    params =
      %{
        "TranscriptionJobName" => name,
        "Media" => %{"MediaFileUri" => uri},
        "MediaFormat" => format,
        "LanguageCode" => language
      }
      |> Map.merge(normalize_opts(opts))

    request(:start_transcription_job, params)
  end

  @doc """
    Lists transcription jobs with the specified status.

    Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_ListTranscriptionJobs.html>

    Examples:
    ```
    # List jobs
    ExAws.Transcribe.list_transcription_jobs()

    # List completed jobs
    ExAws.Transcribe.list_transcription_jobs(status: "COMPLETED")
    ```
  """
  @type list_transcription_jobs_opts :: [
          job_name_contains: binary,
          max_results: integer,
          next_token: binary,
          status: binary
        ]
  @spec list_transcription_jobs(opts :: list_transcription_jobs_opts) :: ExAws.Operation.JSON.t()
  def list_transcription_jobs(opts \\ []) do
    request(:list_transcription_jobs, normalize_opts(opts))
  end

  @doc """
    Returns information about a transcription job.

    Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_GetTranscriptionJob.html>

    Example:
    ```
    ExAws.Transcribe.get_transcription_job("Job1")
    ```
  """
  @spec get_transcription_job(name :: binary) :: ExAws.Operation.JSON.t()
  def get_transcription_job(name) do
    params = %{"TranscriptionJobName" => name}

    request(:get_transcription_job, params)
  end

  defp request(action, params) do
    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    ExAws.Operation.JSON.new(:transcribe, %{
      data: Map.merge(%{"Version" => @version}, params),
      headers: [
        {"X-Amz-Target", "Transcribe.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    })
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys(deep: true)
  end
end
